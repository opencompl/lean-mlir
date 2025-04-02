
import Std.Sat.AIG.CNF
import Std.Sat.AIG.RelabelNat
import Std.Tactic.BVDecide.Bitblast.BVExpr
import Lean.Elab.Term
import Lean.Meta.ForEachExpr
import Lean.Meta.Tactic.Simp.BuiltinSimprocs.BitVec
import Lean

import SSA.Core.Util

open Lean
open Std.Sat
open Std.Tactic.BVDecide

def reconstructCounterExample' (var2Cnf : Std.HashMap BVBit Nat) (assignment : Array (Bool × Nat))
    (aigSize : Nat)  :
    Std.HashMap Nat BVExpr.PackedBitVec := Id.run do
  let mut sparseMap : Std.HashMap Nat (RBMap Nat Bool Ord.compare) := {}

  for (bitVar, cnfVar) in var2Cnf.toArray do
    /-
    The setup of the variables in CNF is as follows:
    1. One auxiliary variable for each node in the AIG
    2. The actual BitVec bitwise variables
    Hence we access the assignment array offset by the AIG size to obtain the value for a BitVec bit.
    We assume that a variable can be found at its index as CaDiCal prints them in order.

    Note that cadical will report an assignment for all literals up to the maximum literal from the
    CNF. So even if variable or AIG bits below the maximum literal did not occur in the CNF they
    will still occur in the assignment that cadical reports.

    There is one crucial thing to consider in addition: If the highest literal that ended up in the
    CNF does not represent the highest variable bit not all variable bits show up in the assignment.
    For this situation we do the same as cadical for literals that did not show up in the CNF:
    set them to true.
    -/
    let idx := cnfVar + aigSize
    let varSet := if h : idx < assignment.size then assignment[idx].fst else true
    let mut bitMap := sparseMap.getD bitVar.var {}
    bitMap := bitMap.insert bitVar.idx varSet
    sparseMap := sparseMap.insert bitVar.var bitMap

  let mut finalMap := Std.HashMap.emptyWithCapacity
  for (bitVecVar, bitMap) in sparseMap.toArray do
    let mut value : Nat := 0
    let mut currentBit := 0
    for (bitIdx, bitValue) in bitMap.toList do
      assert! bitIdx == currentBit
      if bitValue then
        value := value ||| (1 <<< currentBit)
      currentBit := currentBit + 1
    finalMap := finalMap.insert bitVecVar ⟨BitVec.ofNat currentBit value⟩
  return finalMap

open Lean Elab Std Sat AIG Tactic BVDecide Frontend

def solve (bvExpr: BVLogicalExpr) : TermElabM (Option (Std.HashMap Nat BVExpr.PackedBitVec)) := do
    let cadicalTimeoutSec : Nat := 1000
    let cfg: BVDecideConfig := {timeout := 10}

    IO.FS.withTempFile fun _ lratFile => do
      let ctx ← BVDecide.Frontend.TacticContext.new lratFile cfg
      let entry ← IO.lazyPure (fun _ => bvExpr.bitblast)

      let (cnf, map) ← IO.lazyPure (fun _ =>
            let (entry, map) := entry.relabelNat'
            let cnf := AIG.toCNF entry
            (cnf, map))

      let res ← runExternal cnf ctx.solver ctx.lratPath
          (trimProofs := true)
          (timeout := cadicalTimeoutSec)
          (binaryProofs := true)

      match res with
      | .ok _ =>
        return none
      | .error assignment =>
        let equations := reconstructCounterExample' map assignment entry.aig.decls.size
        return .some equations


---- Test Solver function ----
def simpleArith : BVLogicalExpr :=
  let x := BVExpr.const (BitVec.ofNat 5 2)
  let y := BVExpr.const (BitVec.ofNat 5 4)
  let z : BVExpr 5 := BVExpr.var 0
  let sum : BVExpr 5 := BVExpr.bin x BVBinOp.add z
  BoolExpr.literal (BVPred.bin sum BVBinPred.eq y)

syntax (name := testExSolver) "test_solver" : tactic
@[tactic testExSolver]
def testSolverImpl : Tactic := fun _ => do
  let res ← solve simpleArith
  match res with
    | none => pure ()
    | some counterex =>
        for (id, var) in counterex do
          logInfo m! "Results: {id}={var.bv}"
  pure ()

theorem test_solver : False := by
  test_solver


instance : Inhabited BVExpr.PackedBitVec where
  default := { bv := BitVec.ofNat 0 0 }


inductive SubstitutionValue where
    | nat (n : Nat) : SubstitutionValue
    | packedBV  (bv: BVExpr.PackedBitVec) : SubstitutionValue

instance : Inhabited SubstitutionValue where
  default := SubstitutionValue.nat 0


def packedBitVecToSubstitutionValue (map: Std.HashMap Nat BVExpr.PackedBitVec) : Std.HashMap Nat SubstitutionValue :=
  Std.HashMap.ofList (List.map (fun item => (item.fst, SubstitutionValue.packedBV item.snd)) map.toList)

def natToSubstitutionValue (map: Std.HashMap Nat Nat) : Std.HashMap Nat SubstitutionValue :=
  Std.HashMap.ofList (List.map (fun item => (item.fst, SubstitutionValue.nat item.snd)) map.toList)

def substituteBVExpr (bvExpr: BVExpr w) (assignment: Std.HashMap Nat SubstitutionValue) : BVExpr w :=
    match bvExpr with
    | .var idx =>
      if assignment.contains idx then
          let value := assignment[idx]!
          match value with
          | SubstitutionValue.nat n => BVExpr.var n
          | .packedBV packedBitVec =>  BVExpr.const (BitVec.ofNat w packedBitVec.bv.toNat)
      else bvExpr
    | .bin lhs op rhs =>
        BVExpr.bin (substituteBVExpr lhs assignment) op (substituteBVExpr rhs assignment)
    | .un op operand =>
        BVExpr.un op (substituteBVExpr operand assignment)
    | .shiftLeft lhs rhs =>
        BVExpr.shiftLeft (substituteBVExpr lhs assignment) (substituteBVExpr rhs assignment)
    | .shiftRight lhs rhs =>
        BVExpr.shiftRight (substituteBVExpr lhs assignment) (substituteBVExpr rhs assignment)
    | .arithShiftRight lhs rhs =>
        BVExpr.arithShiftRight (substituteBVExpr lhs assignment) (substituteBVExpr rhs assignment)
    -- | .zeroExtend v expr =>
    --     BVExpr.zeroExtend v (substituteBVExpr expr)
    -- | .extract start len expr =>
    --     BVExpr.extract start len (substituteBVExpr expr)
    -- | .append lhs rhs =>
    --     BVExpr.append (substituteBVExpr lhs) (substituteBVExpr rhs)
    | _ => bvExpr --TODO: Handle other constructors


def substitute  (bvLogicalExpr: BVLogicalExpr) (assignment: Std.HashMap Nat SubstitutionValue) :
          BVLogicalExpr :=
  match bvLogicalExpr with
  | .literal (BVPred.bin lhs op rhs) => BoolExpr.literal (BVPred.bin (substituteBVExpr lhs assignment) op (substituteBVExpr rhs assignment))
  | .not boolExpr =>
      BoolExpr.not (substitute boolExpr assignment)
  | .gate op lhs rhs =>
      BoolExpr.gate op (substitute lhs assignment) (substitute rhs assignment)
  | .ite constVar auxVar op3 =>
      BoolExpr.ite (substitute constVar assignment) (substitute auxVar assignment) (substitute op3 assignment)
  | _ => bvLogicalExpr


instance : ToString BVExpr.PackedBitVec where
  toString bitvec := toString bitvec.bv

instance [ToString α] [ToString β] [Hashable α] [BEq α] : ToString (Std.HashMap α β) where
  toString map :=
    "{" ++ String.intercalate ", " (map.toList.map (λ (k, v) => toString k ++ " → " ++ toString v)) ++ "}"


partial def existsForAll (bvExpr: BVLogicalExpr) (existsVars: List Nat) (forAllVars: List Nat):
                  TermElabM (Option (Std.HashMap Nat BVExpr.PackedBitVec)) := do
    let existsRes ← solve bvExpr

    match existsRes with
      | none =>
        logInfo s! "Could not satisfy exists formula for {bvExpr}"
        return none
      | some assignment =>
        let existsVals := assignment.filter fun c _ => existsVars.contains c
        let substExpr := substitute bvExpr (packedBitVecToSubstitutionValue existsVals)
        let forAllRes ← solve (BoolExpr.not substExpr)

        match forAllRes with
          | none =>
            return some existsVals
          | some counterEx =>
              logInfo s! "Found counterexample {counterEx}; rerunning"
              let newExpr := substitute bvExpr (packedBitVecToSubstitutionValue counterEx)
              logInfo s! "New expr: {newExpr}"
              existsForAll (BoolExpr.gate Gate.and bvExpr newExpr) existsVars forAllVars


---- Test ExistsForAll function ---
def leftShiftRightShiftOne : BVLogicalExpr :=
  let bitwidth := 4
  let x : BVExpr bitwidth := BVExpr.var 0
  let c1: BVExpr bitwidth := BVExpr.var 100
  let c2: BVExpr bitwidth := BVExpr.var 101

  -- (x << c1) >> c1 == x & c2
  let lhs := BVExpr.shiftRight (BVExpr.shiftLeft x c1) c1
  let rhs := BVExpr.bin x BVBinOp.and c2
  BoolExpr.literal (BVPred.bin lhs BVBinPred.eq rhs)


def leftShiftRightShiftTwo : BVLogicalExpr :=
  let bitwidth := 4
  let x : BVExpr bitwidth := BVExpr.var 0
  let c1: BVExpr bitwidth := BVExpr.var 100
  let c2: BVExpr bitwidth := BVExpr.var 101
  let c3: BVExpr bitwidth := BVExpr.var 102
  let c4: BVExpr bitwidth := BVExpr.var 103

  -- ((x << c1) >> c2) << c3 == x & c4
  let lhs := BVExpr.shiftLeft (BVExpr.shiftRight (BVExpr.shiftLeft x c1) c2) c3
  let rhs := BVExpr.bin x BVBinOp.and c4
  BoolExpr.literal (BVPred.bin lhs BVBinPred.eq rhs)

def addId : BVLogicalExpr :=
  let bitwidth := 4
  let x: BVExpr bitwidth := BVExpr.var 0
  let c1: BVExpr bitwidth := BVExpr.var 100

  -- x + c1 == x
  let lhs := BVExpr.bin x BVBinOp.add c1
  BoolExpr.literal (BVPred.bin lhs BVBinPred.eq x)

def addInfeasible : BVLogicalExpr :=
  let bitwidth := 4
  let x: BVExpr bitwidth := BVExpr.var 0
  let c1: BVExpr bitwidth := BVExpr.var 100

  BoolExpr.literal (BVPred.bin x BVBinPred.eq c1)


syntax (name := testExFa) "test_exists_for_all" : tactic
@[tactic testExFa]
def testExFaImpl : Tactic := fun _ => do
  -- let res ← existsForAll leftShiftRightShiftOne [100, 101] [0]
  -- let res ← existsForAll leftShiftRightShiftTwo [100, 101, 102, 103] [0]
  let res ← existsForAll addId [100] [0]
  -- let res ← existsForAll addInfeasible [100] [0]
  match res with
    | none => pure ()
    | some counterex =>
        for (id, var) in counterex do
          logInfo m! "Results: {id}={var.bv}"
  pure ()

theorem test_exists_for_all : False := by
  test_exists_for_all


def addConstraints (expr: BVLogicalExpr) (constraints: List (BoolExpr BVPred)) : BVLogicalExpr :=
      match constraints with
      | [] => expr
      | x::xs =>
          addConstraints (BoolExpr.gate Gate.and expr x) xs


def enumerativeSynthesis (origExpr: BVExpr w)  (inputs: List Nat)  (constants: Std.HashMap Nat (BitVec w)) (target: BitVec w) :
                      TermElabM ( List (BVExpr w)) := do
      --- Special constants
      let zero := {bv := BitVec.ofNat w 0: BVExpr.PackedBitVec}
      let one := {bv := BitVec.ofNat w 1: BVExpr.PackedBitVec}
      let minusOne := {bv := BitVec.neg (BitVec.ofNat w 1)}

      let specialConstants := [zero, one, minusOne]

      let inputCombinations := productsList (List.replicate inputs.length specialConstants)
      let constsPermutation := List.permutations constants.keys

      let inputsAndConstants := List.product inputCombinations constsPermutation

      let mut validCombos : List (BVExpr w) := []
      for combo in inputsAndConstants do
          let inputsSubstitutions := packedBitVecToSubstitutionValue (Std.HashMap.ofList (List.zip inputs combo.fst))
          let constantsSubstitutions := natToSubstitutionValue (Std.HashMap.ofList (List.zip constants.keys combo.snd))

          let substitutedExpr := substituteBVExpr origExpr (Std.HashMap.union inputsSubstitutions constantsSubstitutions)
          let firstConstraint := BoolExpr.literal (BVPred.bin (substitutedExpr) BVBinPred.eq (BVExpr.const target))

          let newConstraints := constants.toList.map (fun c => BoolExpr.literal (BVPred.bin (BVExpr.var c.fst) BVBinPred.eq (BVExpr.const c.snd)))
          let newExpr := addConstraints firstConstraint newConstraints

          if let some _ ← solve newExpr then
            validCombos := substitutedExpr :: validCombos

        return validCombos


def negate (bvExpr: BVExpr w) : BVExpr w:=
  -- Two's complement value = 1 + Not(Var)
  BVExpr.bin (BVExpr.const (BitVec.ofNat w 1)) BVBinOp.add (BVExpr.un BVUnOp.not bvExpr)


def binaryOperators : List BVBinOp :=
  [BVBinOp.add] -- TODO: Needs to support more operators


partial def inductiveSynthesis (expr: BVExpr w) (inputs: List Nat) (constants: Std.HashMap Nat (BitVec w)) (target: BitVec w) (depth: Nat) :
                      TermElabM ( List (BVExpr w)) := do
    match depth with
      | 1 => let res ← enumerativeSynthesis expr inputs constants target
             return res
      | _ =>
            let mut res : List (BVExpr w) := []

            let processOp (op: BVBinOp) (f : BVBinOp → BVExpr w) (constId: Nat) (auxVarId: Nat) : TermElabM (List (BVExpr w)) := do
                let lhs := f op
                let bvLogicalExpr := BoolExpr.literal (BVPred.bin lhs BVBinPred.eq (BVExpr.const target))

                if let some assignment ← solve bvLogicalExpr then
                  let newTarget := assignment[auxVarId]!.bv.toNat
                  let results ← inductiveSynthesis expr inputs constants (BitVec.ofNat w newTarget) (depth - 1)

                  return results.map (λ rem => BVExpr.bin (BVExpr.var constId) op rem)

                return []


            for (constId, constVal) in constants.toArray do
              if constVal == target then
                res := BVExpr.var constId :: res
              else
                let constExpr := BVExpr.const constVal

                let auxId := constId + 1
                let auxVar := BVExpr.var auxId

                for op in binaryOperators do
                  let remainingExprs ← processOp op (fun op => BVExpr.bin constExpr op auxVar) constId auxId
                  res := res ++ remainingExprs

                /-
                 Process subtraction operation
                 TODO: Bug: It resolves correctly but since we use BVBinOp.add, it's not yet clear when an operation actually represents a subtraction
                 So 'var101 + ((0x00#8 + var100) + (0x00#8 + var101))' is actually var101 - ((0x00#8 + var100) + (0x00#8 + var101))
                -/
                let subtractionRes ← processOp BVBinOp.add (fun op => BVExpr.bin constExpr op (negate auxVar)) constId auxId
                res := res ++ subtractionRes

            return res


structure ExpressionSynthesisTestConfig where
  {w : Nat}
  bvExpr: BVExpr w
  inputs: List Nat
  constants: Std.HashMap Nat (BitVec w)
  target: BitVec w

def exprSynthesisTestOne : ExpressionSynthesisTestConfig :=
  let bitwidth := 8
  let x : BVExpr bitwidth := BVExpr.var 0
  let y : BVExpr bitwidth := BVExpr.var 1
  let c1: BVExpr bitwidth := BVExpr.var 100
  let c2: BVExpr bitwidth := BVExpr.var 101

  let constants := Std.HashMap.ofList [(100, BitVec.ofNat bitwidth 10), (101, BitVec.ofNat bitwidth 14)]
  let target := BitVec.ofNat bitwidth 24

  let expr := BVExpr.bin (BVExpr.bin x BVBinOp.add c1) BVBinOp.add (BVExpr.bin y BVBinOp.add c2)
  {bvExpr := expr, inputs := [0, 1], constants := constants, target:= target}


syntax (name := testExprSynthesis) "test_expression_synthesis" : tactic
@[tactic testExprSynthesis]
def testExpressionSynthesis : Tactic := fun _ => do
  let config := exprSynthesisTestOne
  let res ← inductiveSynthesis config.bvExpr config.inputs config.constants config.target 3
  logInfo m! "Results: {res} of length: {res.length}"
  pure ()

theorem test_inductive : False := by
  test_expression_synthesis



def getNegativeExamples (bvExpr: BVLogicalExpr) (consts: List Nat) (num: Nat) :
              TermElabM (List (Std.HashMap Nat BVExpr.PackedBitVec)) := do
    -- expr is negated for helper
  let rec helper (expr: BVLogicalExpr) (depth : Nat)
          : TermElabM (List (Std.HashMap Nat BVExpr.PackedBitVec)) := do
        match depth with
          | 0 => return []
          | n + 1 =>
              let solution ← solve expr

              match solution with
              | none => return []
              | some assignment =>
                   let constVals := assignment.filter fun c _ => consts.contains c
                   let newConstraints := constVals.toList.map (fun c => BoolExpr.not (BoolExpr.literal (BVPred.bin (BVExpr.var c.fst) BVBinPred.eq (BVExpr.const c.snd.bv))))

                   let res ← helper (addConstraints expr newConstraints) n
                   return [constVals] ++ res


  helper (BoolExpr.not bvExpr) num

structure PreconditionSynthesisTestConfig where
  expr: BVLogicalExpr



def preconditionSynthesisEx1 : BVLogicalExpr :=
  let bitwidth := 4
  let x : BVExpr bitwidth := BVExpr.var 0
  let c1 : BVExpr bitwidth := BVExpr.var 100
  let c2 : BVExpr bitwidth := BVExpr.var 101
  let c3 : BVExpr bitwidth := BVExpr.var 102

  -- LHS: LShR(x << c1, c2) << c3
  let lhs := BVExpr.shiftLeft (BVExpr.shiftRight (BVExpr.shiftLeft x c1) c2) c3

  -- RHS: x & (LShR(-1 << c1, c2) << c3)
  let negOne : BVExpr bitwidth := BVExpr.const (BitVec.neg (BitVec.ofNat bitwidth 1))
  let rhs := BVExpr.bin x BVBinOp.and (BVExpr.shiftLeft (BVExpr.shiftRight (BVExpr.shiftLeft negOne c1) c2) c3)

  BoolExpr.literal (BVPred.bin lhs BVBinPred.eq rhs)

def negativeExNoneExpected : BVLogicalExpr :=
  let bitwidth := 4
  let x  : BVExpr bitwidth := BVExpr.var 0
  let y  : BVExpr bitwidth := BVExpr.var 1
  let c1 : BVExpr bitwidth := BVExpr.var 100
  let c2 : BVExpr bitwidth := BVExpr.var 101

  -- LHS: (x + c1) - (y + c2)
  let lhs := BVExpr.bin (BVExpr.bin x BVBinOp.add c1) BVBinOp.add (negate (BVExpr.bin y BVBinOp.add c2))

  -- RHS: x - y + (c1 - c2)
  let rhs := BVExpr.bin (BVExpr.bin x BVBinOp.add (negate y)) BVBinOp.add (BVExpr.bin c1 BVBinOp.add (negate c2))

  BoolExpr.literal (BVPred.bin lhs BVBinPred.eq rhs)

syntax (name := testNegativeExample) "test_negative_examples" : tactic
@[tactic testNegativeExample]
def testNegativeEx : Tactic := fun _ => do
  -- let res ← getNegativeExamples preconditionSynthesisEx1 [100, 101, 102] 3
  let res ← getNegativeExamples negativeExNoneExpected [100, 101] 3
  logInfo m! "Results: {res} of length: {res.length}"
  pure ()

theorem test_negative_ex : False := by
  test_negative_examples
