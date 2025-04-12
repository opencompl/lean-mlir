
import Std.Sat.AIG.CNF
import Std.Sat.AIG.RelabelNat
import Std.Tactic.BVDecide.Bitblast.BVExpr
import Lean.Elab.Tactic.BVDecide.Frontend.BVDecide.Reify

import Lean.Elab.Term
import Lean.Meta.ForEachExpr
import Lean.Meta.Tactic.Simp.BuiltinSimprocs.BitVec
import Lean

import SSA.Core.Util

open Lean
open Lean.Meta
open Std.Sat
open Std.Tactic.BVDecide

def reconstructAssignment' (var2Cnf : Std.HashMap BVBit Nat) (assignment : Array (Bool × Nat))
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
        let equations := reconstructAssignment' map assignment entry.aig.decls.size
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

-- theorem test_solver : False := by
--   test_solver


instance : Inhabited BVExpr.PackedBitVec where
  default := { bv := BitVec.ofNat 0 0 }


inductive SubstitutionValue where
    | bvExpr {w} (bvExpr : BVExpr w) : SubstitutionValue
    | nat (n : Nat) : SubstitutionValue
    | packedBV  (bv: BVExpr.PackedBitVec) : SubstitutionValue

instance : Inhabited SubstitutionValue where
  default := SubstitutionValue.nat 0

def bvExprToSubstitutionValue (map: Std.HashMap Nat (BVExpr w)) : Std.HashMap Nat SubstitutionValue :=
      Std.HashMap.ofList (List.map (fun item => (item.fst, SubstitutionValue.bvExpr item.snd)) map.toList)

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
          | .bvExpr (w := wbv) bv =>
            if h : w = wbv
            then h ▸ bv
            else BVExpr.extract 0 w bv
          | .nat n => BVExpr.var n
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

-- theorem test_exists_for_all : False := by
--   test_exists_for_all


def addConstraints (expr: BVLogicalExpr) (constraints: List BVLogicalExpr) : BVLogicalExpr :=
      match constraints with
      | [] => expr
      | x::xs =>
          addConstraints (BoolExpr.gate Gate.and expr x) xs


def enumerativeSynthesis (origExpr: BVExpr w)  (inputs: List Nat)  (constants: Std.HashMap Nat BVExpr.PackedBitVec) (target: BVExpr.PackedBitVec) :
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

          if h : w = target.w then
            let bv' := h ▸ target.bv

            let firstConstraint := BoolExpr.literal (BVPred.bin (substitutedExpr) BVBinPred.eq (BVExpr.const bv'))
            let newConstraints := constants.toList.map (fun c => BoolExpr.literal (BVPred.bin (BVExpr.var c.fst) BVBinPred.eq (BVExpr.const c.snd.bv)))
            let newExpr := addConstraints firstConstraint newConstraints

            if let some _ ← solve newExpr then
              validCombos := substitutedExpr :: validCombos

        return validCombos



def add (op1 : BVExpr w) (op2 : BVExpr w) : BVExpr w :=
  BVExpr.bin op1 BVBinOp.add op2

def negate (bvExpr: BVExpr w) : BVExpr w :=
  -- Two's complement value = 1 + Not(Var)
  BVExpr.bin (BVExpr.const (BitVec.ofNat w 1)) BVBinOp.add (BVExpr.un BVUnOp.not bvExpr)

def subtract (op1 : BVExpr w) (op2 : BVExpr w) : BVExpr w :=
  add op1 (negate op2)


def binaryOperations : List (BVExpr w → BVExpr w → BVExpr w) :=
  [add, subtract] -- TODO: Needs to support more operators



instance : BEq BVExpr.PackedBitVec where
  beq a b := if h : a.w = b.w then
                let b' := h ▸ b.bv
                a.bv == b'
              else
                false

partial def inductiveSynthesis (expr: BVExpr w) (inputs: List Nat) (constants: Std.HashMap Nat BVExpr.PackedBitVec) (target: BVExpr.PackedBitVec) (depth: Nat) :
                      TermElabM ( List (BVExpr w)) := do
    match depth with
      | 0 => return []
      | _ =>
            let mut res : List (BVExpr w) := []

            for (constId, constVal) in constants.toArray do
              if constVal == target then
                res := BVExpr.var constId :: res
                continue

              if h : constVal.w = target.w then
                let targetBv := h ▸ target.bv

                let constExpr := BVExpr.const constVal.bv

                let some maxConstId := constants.keys.max? | throwError "No max value found for map: {constants}"
                let auxId := maxConstId + 1
                let auxVar := BVExpr.var auxId

                for op in binaryOperations do
                  let bvLogicalExpr := BoolExpr.literal (BVPred.bin (op constExpr auxVar) BVBinPred.eq (BVExpr.const targetBv))

                  if let some assignment ← solve bvLogicalExpr then
                    let newTarget := assignment[auxId]!.bv.toNat
                    let expressions ← inductiveSynthesis expr inputs constants {bv := (BitVec.ofNat w newTarget): BVExpr.PackedBitVec} (depth - 1)

                    if h : constVal.w = w then
                      res := res ++ expressions.map (λ expr =>  (h ▸ op) (BVExpr.var constId) expr)
                else
                    throwError m! "Width mismatch for expr : {expr} and target: {target}"
            return res


structure BVExprWrapper where
  width : Nat
  bvExpr: BVExpr width

structure ParsedBVExprState where
  maxFreeVarId : Nat
  maxSymVarId :  Nat
  inputVarToBVExpr : Std.HashMap FVarId BVExprWrapper
  inputBVExprVarToExpr : Std.HashMap Nat FVarId
  symVarToVal : Std.HashMap Nat BVExpr.PackedBitVec

instance : ToString BVExprWrapper where
  toString w :=
      s!" BVExprWrapper \{width: {w.width}, bvExpr: {w.bvExpr}}"

instance : ToString FVarId where
  toString f := s! "{f.name}"

instance : Inhabited ParsedBVExprState where
  default := {maxFreeVarId := 0, maxSymVarId := 1000, inputBVExprVarToExpr := {}, symVarToVal := {}, inputVarToBVExpr := {}}

def printParsedBVExprState (s: ParsedBVExprState) :=
    s!"ParsedBVExprState:\n" ++
    s!"  maxFreeVarId: {s.maxFreeVarId}\n" ++
    s!"  maxSymVarId: {s.maxSymVarId}\n" ++
    s!"  inputVarToBVExpr: {s.inputVarToBVExpr}\n" ++
    s!"  inputBVExprVarToExpr: {s.inputBVExprVarToExpr}\n" ++
    s!"  symVarToVal: {s.symVarToVal}"


instance : ToMessageData ParsedBVExprState where
  toMessageData s := printParsedBVExprState s


instance : ToString ParsedBVExprState where
  toString s := printParsedBVExprState s


structure ParsedBVExpr where
  width : Nat
  bvExpr: BVExpr width
  symVars: Std.HashMap Nat BVExpr.PackedBitVec
  inputVars : Std.HashMap Nat FVarId

structure ParsedBVLogicalExpr where
  lhs: ParsedBVExpr
  rhs: ParsedBVExpr
  bvLogicalExpr: BVLogicalExpr
  state: ParsedBVExprState


def expressionSynthesis (lhs: ParsedBVExpr) (rhs: ParsedBVExpr) (depth: Nat) :
                      TermElabM ( Std.HashMap Nat (List (BVExpr lhs.width))) := do

    let mut results : Std.HashMap Nat (List (BVExpr lhs.width)) := Std.HashMap.emptyWithCapacity
    for (targetId, targetVal) in rhs.symVars.toArray do
        let exprs ← inductiveSynthesis lhs.bvExpr lhs.inputVars.keys lhs.symVars targetVal depth

        match exprs with
        | [] => logInfo m! "Inductive synthesis failed; performing enumerative synthesis"
                results := results.insert targetId (← enumerativeSynthesis lhs.bvExpr lhs.inputVars.keys lhs.symVars targetVal)
        | _  => results := results.insert targetId exprs

    return results

structure ExpressionSynthesisTestConfig where
  {w : Nat}
  bvExpr: BVExpr w
  inputs: List Nat
  constants: Std.HashMap Nat BVExpr.PackedBitVec
  targets: Std.HashMap Nat BVExpr.PackedBitVec

def exprSynthesisTestOne : ParsedBVLogicalExpr :=
  let bitwidth := 8
  let x : BVExpr bitwidth := BVExpr.var 0
  let y : BVExpr bitwidth := BVExpr.var 1
  let c1: BVExpr bitwidth := BVExpr.var 100
  let c2: BVExpr bitwidth := BVExpr.var 101

  let fvar : FVarId := default

  -- (x + 10) + (y + 14) = 24
  let lhsExpr := BVExpr.bin (BVExpr.bin x BVBinOp.add c1) BVBinOp.add (BVExpr.bin y BVBinOp.add c2)
  let lhs := {bvExpr := lhsExpr, width := bitwidth, symVars := Std.HashMap.ofList [(100, {bv := BitVec.ofNat bitwidth 10 }), (101, {bv := BitVec.ofNat bitwidth 14})] , inputVars := Std.HashMap.ofList [(0, fvar), (1, fvar)] : ParsedBVExpr}

  let rhsExpr := BVExpr.var 102
  let rhs := {bvExpr := rhsExpr, width := bitwidth, symVars := Std.HashMap.ofList [(102, {bv := BitVec.ofNat bitwidth 24})] , inputVars := {} : ParsedBVExpr}

  let state : ParsedBVExprState := default
  {bvLogicalExpr := BoolExpr.literal (BVPred.bin lhsExpr BVBinPred.eq rhsExpr), lhs := lhs, rhs := rhs, state := state}


syntax (name := testExprSynthesis) "test_expression_synthesis" : tactic
@[tactic testExprSynthesis]
def testExpressionSynthesis : Tactic := fun _ => do
  let config := exprSynthesisTestOne
  let res ← expressionSynthesis config.lhs config.rhs 3
  logInfo m! "Results: {res}"
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

-- theorem test_negative_ex : False := by
--   test_negative_examples

def generateSketches (symVars: List (BVExpr w)) : List (BVExpr w) := Id.run do
    match symVars with
      | [] => symVars
      | _::[] => symVars
      | x::xs =>
          let remSketches := generateSketches xs
          let mut res : List (BVExpr w) := []
          for op in binaryOperations do
            for sketch in remSketches do
              res := (op x sketch) :: res

          res

def generatePreconditions (bvExpr: BVLogicalExpr) (positiveExample: Std.HashMap Nat BVExpr.PackedBitVec)  (bitwidth: Nat) (maxConjuctions : Nat)
              : TermElabM (List BVLogicalExpr) := do

    let constants := positiveExample.keys
    let maxConstantId := constants.max?
    -- TODO: Make the width a component for preconditions
    match maxConstantId with
    | none => return []
    | some max =>
          let negativeExamples ← getNegativeExamples bvExpr constants 3

          if negativeExamples.isEmpty then
            return []

          let symbolicVarIds : List Nat := (List.range constants.length).map (fun c => max + c)
          let symbolicVars : List (BVExpr bitwidth) := symbolicVarIds.map (fun c => BVExpr.var c)

          let expressionSketches := generateSketches symbolicVars

          let zero := BVExpr.const (BitVec.ofNat bitwidth 0)
          let one := BVExpr.const (BitVec.ofNat bitwidth 1)

          let specialConstants := [zero, one]
          let sketchInputs := (constants.map (fun c => BVExpr.var c)) ++ specialConstants

          let mut inputCombinations := productsList (List.replicate constants.length sketchInputs)

          let specialConstantsSet := Std.HashSet.ofList specialConstants
          inputCombinations := inputCombinations.filter (fun combo =>
                                                            let comboSet := Std.HashSet.ofList combo
                                                            comboSet.size > 1 && comboSet != specialConstantsSet
                                                      )

          let mut preconditionCandidates : List BVLogicalExpr := []

          -- Check for power of 2: const & (const - 1) == 0
          for (const, _) in positiveExample.toArray do
            let lhs := BVExpr.bin (BVExpr.var const) BVBinOp.and (BVExpr.bin (BVExpr.var const) BVBinOp.add (negate one))
            let powerOf2 := BoolExpr.literal (BVPred.bin lhs BVBinPred.eq zero)

            let substitutedExpr := substitute powerOf2 (packedBitVecToSubstitutionValue positiveExample)
            if let some _ ← solve substitutedExpr then
                preconditionCandidates := powerOf2 :: preconditionCandidates

          let eqToZero (expr: BVExpr bitwidth) : BVLogicalExpr :=
            BoolExpr.literal (BVPred.bin expr BVBinPred.eq zero)

          let neqToZero (expr: BVExpr bitwidth) : BVLogicalExpr :=
            BoolExpr.not (BoolExpr.literal (BVPred.bin expr BVBinPred.eq zero))

          let ltZero (expr: BVExpr bitwidth) : BVLogicalExpr :=
            BoolExpr.literal (BVPred.bin expr BVBinPred.ult zero)

          let gtZero (expr: BVExpr bitwidth) : BVLogicalExpr :=
            BoolExpr.gate  Gate.and (BoolExpr.not (eqToZero expr)) (BoolExpr.not (ltZero expr))

          let gteZero (expr: BVExpr bitwidth) : BVLogicalExpr :=
            BoolExpr.gate  Gate.or (eqToZero expr) (gtZero expr)

          let lteZero (expr : BVExpr bitwidth) : BVLogicalExpr :=
            BoolExpr.gate  Gate.or (eqToZero expr) (ltZero expr)

          for sketch in expressionSketches do
            for combo in inputCombinations do
              let symbolicVarsSubstitution := Std.HashMap.ofList (List.zip symbolicVarIds combo)
              let substitutedSymbolicVarsExpr := substituteBVExpr sketch (bvExprToSubstitutionValue symbolicVarsSubstitution)

              let positiveExpr := substituteBVExpr substitutedSymbolicVarsExpr (packedBitVecToSubstitutionValue positiveExample)

              let mut eqToExpr := eqToZero positiveExpr
              let mut ltExpr := ltZero positiveExpr
              let mut gtExpr := gtZero positiveExpr
              let mut lteExpr := lteZero positiveExpr
              let mut gteExpr := gteZero positiveExpr

              for negativeEx in negativeExamples do
                  let negativeExpr := substituteBVExpr substitutedSymbolicVarsExpr (packedBitVecToSubstitutionValue negativeEx)

                  eqToExpr := addConstraints eqToExpr [neqToZero negativeExpr]
                  ltExpr := addConstraints ltExpr [gteZero negativeExpr]
                  gtExpr := addConstraints gtExpr [lteZero negativeExpr]
                  lteExpr := addConstraints lteExpr [gtZero negativeExpr]
                  gteExpr := addConstraints gteExpr [ltZero negativeExpr]


              if let some _ ← solve eqToExpr then
                  preconditionCandidates := eqToZero substitutedSymbolicVarsExpr :: preconditionCandidates

              if let some _ ← solve ltExpr then
                  preconditionCandidates := ltZero substitutedSymbolicVarsExpr :: preconditionCandidates

              if let some _ ← solve gtExpr then
                  preconditionCandidates := gtZero substitutedSymbolicVarsExpr :: preconditionCandidates

              if let some _ ← solve lteExpr then
                  preconditionCandidates := lteZero substitutedSymbolicVarsExpr :: preconditionCandidates

              if let some _ ← solve gteExpr then
                  preconditionCandidates := gteZero substitutedSymbolicVarsExpr :: preconditionCandidates

          let mut validCandidates : List BVLogicalExpr := []
          for candidate in preconditionCandidates do
              if let none ← solve (BoolExpr.gate Gate.and candidate (BoolExpr.not bvExpr)) then
                  validCandidates := candidate :: validCandidates

          -- TODO: Combining conditions

          return validCandidates

structure PreconditionSynthesisTestConfig where
  expr: BVLogicalExpr
  positiveExample: Std.HashMap Nat BVExpr.PackedBitVec
  bitWidth: Nat

def preconditionSynthesisEx1 : PreconditionSynthesisTestConfig :=
  let bitwidth := 8
  let x : BVExpr bitwidth := BVExpr.var 0
  let c1 : BVExpr bitwidth := BVExpr.var 100
  let c2 : BVExpr bitwidth := BVExpr.var 101
  let c3 : BVExpr bitwidth := BVExpr.var 102

  -- LHS: LShR(x << c1, c2) << c3
  let lhs := BVExpr.shiftLeft (BVExpr.shiftRight (BVExpr.shiftLeft x c1) c2) c3

  -- RHS: x & (LShR(-1 << c1, c2) << c3)
  let negOne : BVExpr bitwidth := BVExpr.const (BitVec.neg (BitVec.ofNat bitwidth 1))
  let rhs := BVExpr.bin x BVBinOp.and (BVExpr.shiftLeft (BVExpr.shiftRight (BVExpr.shiftLeft negOne c1) c2) c3)

  let expr := BoolExpr.literal (BVPred.bin lhs BVBinPred.eq rhs)
  let positiveExample : Std.HashMap Nat BVExpr.PackedBitVec := Std.HashMap.ofList [(100, {bv := BitVec.ofNat bitwidth  8, w := bitwidth : BVExpr.PackedBitVec}),
                                             (101, {bv := BitVec.ofNat bitwidth  16, w := bitwidth : BVExpr.PackedBitVec}),
                                             (102, {bv := BitVec.ofNat bitwidth  8, w := bitwidth : BVExpr.PackedBitVec})]

  {expr := expr, positiveExample := positiveExample, bitWidth := bitwidth}


syntax (name := testPreconditionSynthesis) "test_precondition_synthesis" : tactic
@[tactic testPreconditionSynthesis]
def testPrecondSynthesis : Tactic := fun _ => do
  -- let res ← getNegativeExamples preconditionSynthesisEx1 [100, 101, 102] 3
  let ex := preconditionSynthesisEx1
  let res ← generatePreconditions ex.expr ex.positiveExample ex.bitWidth 2
  logInfo m! " Precondition synthesis results: {res} of length: {res.length}"
  pure ()

-- theorem test_precondition_synthesis : False := by
--   test_precondition_synthesis


abbrev ParseBVExprM := StateRefT ParsedBVExprState MetaM

partial def toBVExpr (expr : Expr) (targetWidth: Nat) : ParseBVExprM (Option (BVExprWrapper)) := do
  go expr
  where

  go (x : Expr) : ParseBVExprM (Option (BVExprWrapper)) := do
    match_expr x with
    | HAnd.hAnd _ _ _ _ lhsExpr rhsExpr =>
        binaryReflection lhsExpr rhsExpr BVBinOp.and
    | HXor.hXor _ _ _ _ lhsExpr rhsExpr =>
        binaryReflection lhsExpr rhsExpr BVBinOp.xor
    | HAdd.hAdd _ _ _ _ lhsExpr rhsExpr =>
        binaryReflection lhsExpr rhsExpr BVBinOp.add
    | HSub.hSub _ _ _ _ lhsExpr rhsExpr =>
        let some lhs ← go lhsExpr | return none
        let some rhs ← go rhsExpr | return none
        if h : lhs.width = rhs.width then
          let rhs' := h ▸ rhs.bvExpr  -- cast rhs to BVExpr lhs.width
          return some {bvExpr := subtract lhs.bvExpr rhs', width := lhs.width}
        else
          return none
    | HMul.hMul _ _ _ _ lhsExpr rhsExpr =>
        binaryReflection lhsExpr rhsExpr BVBinOp.mul
    | HDiv.hDiv _ _ _ _ lhsExpr rhsExpr =>
        binaryReflection lhsExpr rhsExpr BVBinOp.udiv
    | HMod.hMod _ _ _ _ lhsExpr rhsExpr =>
        binaryReflection lhsExpr rhsExpr BVBinOp.umod
    | Complement.complement _ _ innerExpr =>
        let some inner ← go innerExpr | return none
        return some {bvExpr:= BVExpr.un BVUnOp.not inner.bvExpr, width := inner.width}
    | HShiftLeft.hShiftLeft _ _ _ _ innerExpr distanceExpr =>
        shiftReflection innerExpr distanceExpr BVExpr.shiftLeft
    | HShiftRight.hShiftRight _ _ _ _ innerExpr distanceExpr =>
        shiftReflection innerExpr distanceExpr BVExpr.shiftRight
    | BitVec.sshiftRight _ _ innerExpr distanceExpr =>
        shiftReflection innerExpr distanceExpr BVExpr.arithShiftRight
    | BitVec.sshiftRight' _ _ innerExpr distanceExpr =>
        shiftReflection innerExpr distanceExpr BVExpr.arithShiftRight
    | HAppend.hAppend _ _ _ _ lhsExpr rhsExpr =>
        let some lhs ← go lhsExpr | return none
        let some rhs ← go rhsExpr | return none
        return some {bvExpr := BVExpr.append lhs.bvExpr rhs.bvExpr rfl}
    | BitVec.extractLsb' _ _ _ _ =>
           throwError m! "Does not support BitVec.extractLsb' operations"
        -- let some start ← getNatValue? startExpr | return none
        -- let some len ← getNatValue? lenExpr | return none
        -- let some inner ← go innerExpr | return none
        -- return some {bvExpr := BVExpr.extract start len inner.bvExpr, width := len}
    | BitVec.rotateLeft _ innerExpr distanceExpr =>
        rotateReflection innerExpr distanceExpr BVUnOp.rotateLeft
    | BitVec.rotateRight _ innerExpr distanceExpr =>
        rotateReflection innerExpr distanceExpr BVUnOp.rotateRight
    | _ =>
        let currState: ParsedBVExprState ← get
        let natVal ← getNatValue? x
        let bitVal ← getBitVecValue? x

        match (natVal, bitVal) with
        | (some v, none) =>
              let newId := currState.maxSymVarId + 1
              let bv := BitVec.ofNat targetWidth v
              let newExpr : BVExpr targetWidth := BVExpr.var newId

              let updatedState : ParsedBVExprState := { currState with maxSymVarId := newId, symVarToVal := currState.symVarToVal.insert newId {bv := bv: BVExpr.PackedBitVec}}
              set updatedState
              return some {bvExpr := newExpr, width := targetWidth}
        | (none, some bvProd) =>
              let newId := currState.maxSymVarId + 1
              let newExpr : BVExpr targetWidth := BVExpr.var newId

              let updatedState : ParsedBVExprState := { currState with maxSymVarId := newId, symVarToVal := currState.symVarToVal.insert newId {bv := bvProd.snd: BVExpr.PackedBitVec}}
              set updatedState
              return some {bvExpr := newExpr, width := targetWidth}
        | _ =>
            let .fvar name := x | throwError m! "Unknown expression: {x}"

            let existingVar? := currState.inputVarToBVExpr[name]?
            match existingVar? with
            | some val => return val
            | none =>
                let newId := currState.maxFreeVarId + 1
                let newExpr : BVExpr targetWidth :=  BVExpr.var newId
                let newWrappedExpr : BVExprWrapper := {bvExpr := newExpr, width := targetWidth}

                let updatedState : ParsedBVExprState := {currState with maxFreeVarId := newId, inputVarToBVExpr := currState.inputVarToBVExpr.insert name newWrappedExpr, inputBVExprVarToExpr := currState.inputBVExprVarToExpr.insert newId name}
                set updatedState
                return some newWrappedExpr


  rotateReflection (innerExpr: Expr) (distanceExpr : Expr) (rotateOp: Nat → BVUnOp)
          : ParseBVExprM (Option (BVExprWrapper)) := do
      let some inner ← go innerExpr | return none
      let some distance ← getNatValue? distanceExpr | return none
      return some {bvExpr := BVExpr.un (rotateOp distance) inner.bvExpr, width := inner.width}


  shiftReflection (innerExpr : Expr) (distanceExpr : Expr) (shiftOp : {m n : Nat} → BVExpr m → BVExpr n → BVExpr m)
        : ParseBVExprM (Option (BVExprWrapper)) := do
      let some inner ← go innerExpr | return none
      let some distance ← go distanceExpr | return none
      return some {bvExpr :=  shiftOp inner.bvExpr distance.bvExpr, width := inner.width}


  getConstantBVExpr? (nExpr : Expr) (vExpr : Expr) : ParseBVExprM (Option (BVExprWrapper)) := do
        let some n  ← getNatValue? nExpr | return none
        let some v ← getNatValue? vExpr | return none

        return some {bvExpr := BVExpr.const (BitVec.ofNat n v), width := n}

  binaryReflection (lhsExpr rhsExpr : Expr) (op : BVBinOp) : ParseBVExprM (Option (BVExprWrapper)) := do
    let some lhs ← go lhsExpr | return none
    let some rhs ← go rhsExpr | return none

    if h : lhs.width = rhs.width then
      let rhs' := h ▸ rhs.bvExpr  -- cast rhs to BVExpr lhs.width
      return some {bvExpr := BVExpr.bin lhs.bvExpr op rhs', width := lhs.width}
    else
      return none


def parseExprs (lhsExpr rhsExpr : Expr) (targetWidth : Nat): ParseBVExprM (Option ParsedBVLogicalExpr) := do
  let some lhsRes ← toBVExpr lhsExpr targetWidth | throwError "Could not extract lhs: {lhsExpr}"

  let state ← get
  let lhs: ParsedBVExpr := {bvExpr := lhsRes.bvExpr, width := lhsRes.width, symVars := state.symVarToVal, inputVars := state.inputBVExprVarToExpr}

  let some rhsRes ← toBVExpr rhsExpr targetWidth | throwError "Could not extract rhs: {rhsExpr}"
  let state ← get

  let rhsInputVars := state.inputBVExprVarToExpr.filter fun k _ => !lhs.inputVars.contains k
  let rhsSymVars := state.symVarToVal.filter fun k _ => !lhs.symVars.contains k

  let rhs: ParsedBVExpr := {bvExpr := rhsRes.bvExpr, width := rhsRes.width, symVars := rhsSymVars, inputVars := rhsInputVars}

  if h : lhsRes.width = rhsRes.width then
    let rhsExpr := h ▸ rhsRes.bvExpr
    let bvLogicalExpr := BoolExpr.literal (BVPred.bin lhsRes.bvExpr BVBinPred.eq rhsExpr)
    logInfo m! "BVLogicalExpr: {bvLogicalExpr}"

    return some {lhs := lhs, rhs := rhs, state := state, bvLogicalExpr := bvLogicalExpr}

  return none

elab "#reducewidth" expr:term " : " target:term : command =>
  open Lean Lean.Elab Command Term in
  withoutModifyingEnv <| runTermElabM fun _ => Term.withDeclName `_reduceWidth do
      let targetExpr ← Term.elabTerm target (some (mkConst ``Nat))
      let some targetWidth ← getNatValue? targetExpr | throwError "Invalid width provided"

      let hExpr ← Term.elabTerm expr none
      logInfo m! "hexpr: {hExpr}"

      match_expr hExpr with
      | Eq _ lhsExpr rhsExpr =>
           let initialState : ParsedBVExprState := { maxFreeVarId := 0, maxSymVarId := 1000, symVarToVal := Std.HashMap.emptyWithCapacity, inputBVExprVarToExpr := Std.HashMap.emptyWithCapacity, inputVarToBVExpr := Std.HashMap.emptyWithCapacity}
           let some (parsedBvExpr) ← (parseExprs lhsExpr rhsExpr targetWidth).run' initialState | throwError "Unsupported expression provided"

           let bvExpr := parsedBvExpr.bvLogicalExpr
           let state := parsedBvExpr.state
           logInfo m! "bvExpr: {bvExpr}, state: {state}"

           let some results ← existsForAll bvExpr state.symVarToVal.keys state.inputBVExprVarToExpr.keys | throwError m! "Could not reduce {expr} to width {targetWidth}"
           logInfo m! "Results: {results}"
      | _ =>
            logInfo m! "Could not match"
      pure ()


variable {x y z : BitVec 64}
#reducewidth (x + 0 = x) : 4

#reducewidth ((x <<< 8) >>> 16) <<< 8 = x &&& 0xffff00#64 : 4

#reducewidth (x <<< 3  = y + (BitVec.ofNat 64 3)) : 4


def updateConstantValues (bvExpr: ParsedBVExpr) (assignments: Std.HashMap Nat BVExpr.PackedBitVec)
             : ParsedBVExpr := Id.run do
    let mut updatedSymVars : Std.HashMap Nat BVExpr.PackedBitVec := Std.HashMap.emptyWithCapacity

    for (id, _) in bvExpr.symVars.toArray do
      updatedSymVars := updatedSymVars.insert id assignments[id]!

    return {bvExpr with symVars := updatedSymVars}

elab "#generalize" expr:term: command =>
  open Lean Lean.Elab Command Term in
  withoutModifyingEnv <| runTermElabM fun _ => Term.withDeclName `_reduceWidth do
      let targetWidth := 4 -- TODO: We should try a range of widths

      let hExpr ← Term.elabTerm expr none
      -- let hExpr ← instantiateMVars (← whnfR  hExpr)
      logInfo m! "hexpr: {hExpr}"

      match_expr hExpr with
      | Eq _ lhsExpr rhsExpr =>
           let initialState : ParsedBVExprState := { maxFreeVarId := 0, maxSymVarId := 1000, symVarToVal := Std.HashMap.emptyWithCapacity, inputBVExprVarToExpr := Std.HashMap.emptyWithCapacity, inputVarToBVExpr := Std.HashMap.emptyWithCapacity}
           let some parsedBVExpr ← (parseExprs lhsExpr rhsExpr targetWidth).run' initialState | throwError "Unsupported expression provided"

           let bvLogicalExpr := parsedBVExpr.bvLogicalExpr
           let state := parsedBVExpr.state

           logInfo m! "bvExpr: {bvLogicalExpr}, state: {state}"

           let some reducedWidthValues ← existsForAll bvLogicalExpr state.symVarToVal.keys state.inputBVExprVarToExpr.keys | throwError m! "Could not reduce {expr} to width {targetWidth}"
           logInfo m! "Constant values in width {targetWidth}: {reducedWidthValues}"

           let lhs := updateConstantValues parsedBVExpr.lhs reducedWidthValues
           let rhs := updateConstantValues parsedBVExpr.rhs reducedWidthValues

           let exprSynthesisResults ← expressionSynthesis lhs rhs 3
           logInfo m! "Expression synthesis results: {exprSynthesisResults}"

          /-
          Here, we evaluate generate preconditions for different combinations of target values on the RHS.
          If we have only one target on the RHS, then we're just going through the list of the generated expressions.
          -/
           let resultsCombo := productsList exprSynthesisResults.values

           for combo in resultsCombo do
              -- Substitute the generated expressions into the main one, so the constants on the RHS are expressed in terms of the left.
              let zippedCombo := Std.HashMap.ofList (List.zip rhs.symVars.keys combo)
              let substitutedBVLogicalExpr := substitute bvLogicalExpr (bvExprToSubstitutionValue zippedCombo)

              let positiveExample := reducedWidthValues.filter (fun k  _  => ! zippedCombo.contains k)
              let preconditions ← generatePreconditions substitutedBVLogicalExpr positiveExample targetWidth 2

              logInfo m! "Expr: {substitutedBVLogicalExpr} has preconditions: {preconditions}"
      | _ =>
            logInfo m! "Could not match"
      pure ()


#generalize (x + 5) + (y + 1)  =  x + y + 6
#generalize (x + 5) - (y + 1)  =  x - y + 4

variable {x: BitVec 32}
#generalize (x <<< 10) <<< 14 = x <<< 24 --TODO: The exists/for-all solution is correct, but it prevents us from getting a good solution
