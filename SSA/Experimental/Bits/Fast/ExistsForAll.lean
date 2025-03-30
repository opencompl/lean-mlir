
import Std.Sat.AIG.CNF
import Std.Sat.AIG.RelabelNat
import Std.Tactic.BVDecide.Bitblast.BVExpr
import Lean.Elab.Term
import Lean.Meta.ForEachExpr
import Lean.Meta.Tactic.Simp.BuiltinSimprocs.BitVec
import Lean

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

  let mut finalMap := Std.HashMap.empty
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

def cadicalTimeoutSec : Nat := 1000
def solver (bvExpr: BVLogicalExpr) : TermElabM (Option (Std.HashMap Nat BVExpr.PackedBitVec)) := do
    --TODO: Can this function return a model class like in Python?
    let cfg: BVDecideConfig := {timeout := 10}
    IO.FS.withTempFile fun _ lratFile => do
      let ctx ← BVDecide.Frontend.TacticContext.new lratFile cfg
      logInfo m! "Bitblasting BVLogicalExpr to AIG"
      let entry ← IO.lazyPure (fun _ => bvExpr.bitblast)

      logInfo m! "Converting AIG to CNF"
      let (cnf, map) ← IO.lazyPure (fun _ =>
            let (entry, map) := entry.relabelNat'
            let cnf := AIG.toCNF entry
            (cnf, map))

      logInfo m! "Obtaining external proof certificate"
      let res ← runExternal cnf ctx.solver ctx.lratPath
          (trimProofs := true)
          (timeout := cadicalTimeoutSec)
          (binaryProofs := true)

      match res with
      | .ok _ =>
        logInfo m! "SAT solver found a proof."
        return none
      | .error assignment =>
        logInfo m! "SAT solver found a counter example."
        let equations := reconstructCounterExample' map assignment entry.aig.decls.size
        return .some equations


def substitute  (bvLogicalExpr: BVLogicalExpr) (assignment: Std.HashMap Nat BVExpr.PackedBitVec) : BVLogicalExpr :=
  let rec substituteBVExpr {w} (bvExpr : BVExpr w) : BVExpr w :=
    match bvExpr with
    | .var idx =>
      match assignment[idx]? with
      | some packedBitVec =>
          BVExpr.const (BitVec.ofNat w packedBitVec.bv.toNat) --(packedBitVec.bv)
      | _ => bvExpr
    | .bin lhs op rhs =>
        BVExpr.bin (substituteBVExpr lhs) op (substituteBVExpr rhs)
    | .un op operand =>
        BVExpr.un op (substituteBVExpr operand)
    | .shiftLeft lhs rhs =>
        BVExpr.shiftLeft (substituteBVExpr lhs) (substituteBVExpr rhs)
    | .shiftRight lhs rhs =>
        BVExpr.shiftRight (substituteBVExpr lhs) (substituteBVExpr rhs)
    | .arithShiftRight lhs rhs =>
        BVExpr.arithShiftRight (substituteBVExpr lhs) (substituteBVExpr rhs)
    | _ => bvExpr --TODO: handle other constructors


  match bvLogicalExpr with
  | .literal (BVPred.bin lhs op rhs) => BoolExpr.literal (BVPred.bin (substituteBVExpr lhs) op (substituteBVExpr rhs))
  | .not boolExpr =>
      BoolExpr.not (substitute boolExpr assignment)
  | .gate op lhs rhs =>
      BoolExpr.gate op (substitute lhs assignment) (substitute rhs assignment)
  | .ite op1 op2 op3 =>
      BoolExpr.ite (substitute op1 assignment) (substitute op2 assignment) (substitute op3 assignment)
  | _ => bvLogicalExpr



structure ExistsForAllConfig where
  expr : BVLogicalExpr
  existsVars : List Nat
  forAllVars : List Nat
  numAttempts: Nat

partial def existsForAll (bvExpr: BVLogicalExpr) (existsVars: List Nat) (forAllVars: List Nat):
                  TermElabM (Option (Std.HashMap Nat BVExpr.PackedBitVec)) := do
    let existsRes ← solver bvExpr

    match existsRes with
      | none =>
        logInfo s! "Could not satisfy exists formula for {bvExpr}"
        return none
      | some assignment =>
        let existsVals := assignment.filter fun c _ => existsVars.contains c
        let substExpr := substitute bvExpr existsVals
        let forAllRes ← solver (BoolExpr.not substExpr)

        match forAllRes with
          | none =>
            return some existsVals
          | some counterEx =>
              logInfo s! "Found counterexample; rerunning"
              let newExpr := substitute bvExpr counterEx
              existsForAll (BoolExpr.gate Gate.and bvExpr newExpr) existsVars forAllVars


def bvExpr : BVLogicalExpr :=
  let x := BVExpr.const (BitVec.ofNat 5 2)
  let y := BVExpr.const (BitVec.ofNat 5 4)
  let z : BVExpr 5 := BVExpr.var 0
  let sum : BVExpr 5 := BVExpr.bin x BVBinOp.add z
  BoolExpr.literal (BVPred.bin sum BVBinPred.eq y)


syntax (name := testExSolver) "test_solver" : tactic
@[tactic testExSolver]
def testSolverImpl : Tactic := fun _ => do
  let res ← solver bvExpr
  match res with
    | none => pure ()
    | some counterex =>
        for (id, var) in counterex do
          logInfo m! "Results: {id}={var.bv}"
  pure ()

theorem test_solver : False := by
  test_solver


def leftShiftRightShift : BVLogicalExpr :=
  let bitwidth := 4
  let x : BVExpr bitwidth := BVExpr.var 0
  let c1: BVExpr bitwidth := BVExpr.var 100
  let c2: BVExpr bitwidth := BVExpr.var 101
  let c3: BVExpr bitwidth := BVExpr.var 102
  let c4: BVExpr bitwidth := BVExpr.var 103

  -- ((x << c1) >> c2) << c3 == x & c4
  let lhs := BVExpr.shiftLeft (BVExpr.arithShiftRight (BVExpr.shiftLeft x c1) c2) c3
  let rhs := BVExpr.bin x BVBinOp.and c4
  BoolExpr.literal (BVPred.bin lhs BVBinPred.eq rhs)

def addConst : BVLogicalExpr :=
  let bitwidth := 4
  let x: BVExpr bitwidth := BVExpr.var 0
  let c1: BVExpr bitwidth := BVExpr.var 100

  -- x + c1 == c1
  let lhs := BVExpr.bin x BVBinOp.add c1
  BoolExpr.literal (BVPred.bin lhs BVBinPred.eq x)

syntax (name := testExFa) "test_exists_for_all" : tactic
@[tactic testExFa]
def testExFaImpl : Tactic := fun _ => do
  -- let res ← existsForAll leftShiftRightShift [100, 101, 102, 103] [0]
  let res ← existsForAll addConst [100] [0]
  match res with
    | none => pure ()
    | some counterex =>
        for (id, var) in counterex do
          logInfo m! "Results: {id}={var.bv}"
  pure ()

theorem test_exists_for_all : False := by
  test_exists_for_all







-- structure Solver where
--   constraints : IO.Ref (List BVLogicalExpr)
--   modelRef : IO.Ref (Std.HashMap Expr BVExpr.PackedBitVec)

-- namespace Solver

-- def new : IO Solver := do
--   let constraints ← IO.mkRef ([] : List BVLogicalExpr)
--   let modelRef ← IO.mkRef ({} : Std.HashMap Expr BVExpr.PackedBitVec)
--   return { constraints, modelRef }

-- def add (s : Solver) (expr : BVLogicalExpr) : IO Unit := do
--   s.constraints.modify (λ cs => expr :: cs)


-- def generateModel (s : Solver) : IO (Std.HashMap Expr BVExpr.PackedBitVec) := do
--   --TODO
--   return {}

-- def check (s : Solver) : IO Bool := do
--   --TODO: Invoke the solver function and update the model
--   return True


-- def model (s : Solver) : IO (Std.HashMap Expr BVExpr.PackedBitVec) := do
--   s.modelRef.get

-- end Solver
