
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

def cadicalTimeoutSec : Nat := 1000

/--
Verify that a proof certificate is valid for a given formula.
-/
def verifyCert (cnf : CNF Nat) (cert : String) : Bool :=
  match LRAT.parseLRATProof cert.toUTF8 with
  | .ok lratProof => LRAT.check lratProof cnf
  | .error _ => false

theorem verifyCert_correct : ∀ cnf cert, verifyCert cnf cert = true → cnf.Unsat := by
  intro c b h1
  unfold verifyCert at h1
  split at h1
  . apply LRAT.check_sound
    assumption
  . contradiction


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

/--
Verify that `cert` is an UNSAT proof for the SAT problem obtained by bitblasting `bv`.
-/
def verifyBVExpr (bv : BVLogicalExpr) (cert : String) : Bool :=
  verifyCert (AIG.toCNF bv.bitblast.relabelNat) cert

theorem unsat_of_verifyBVExpr_eq_true (bv : BVLogicalExpr) (c : String)
    (h : verifyBVExpr bv c = true) :
    bv.Unsat := by
  apply BVLogicalExpr.unsat_of_bitblast
  rw [← AIG.Entrypoint.relabelNat_unsat_iff]
  rw [← AIG.toCNF_equisat]
  apply verifyCert_correct
  rw [verifyBVExpr] at h
  assumption

open Lean Elab Std Sat AIG Tactic BVDecide Frontend

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

      -- let flipper := (fun (expr, {width, atomNumber, synthetic}) => (atomNumber, (width, expr, synthetic)))
      -- let atomsPairs := (← getThe State).atoms.toList.map flipper
      -- let atomsAssignment := Std.HashMap.ofList atomsPairs

      match res with
      | .ok cert =>
        logInfo m! "SAT solver found a proof."
        -- let proof ← cert.toReflectionProof ctx bvExpr ``verifyBVExpr ``unsat_of_verifyBVExpr_eq_true -- can get rid of it
        return none
      | .error assignment =>
        logInfo m! "SAT solver found a counter example."
        let equations := reconstructCounterExample' map assignment entry.aig.decls.size
        return .some equations

def bvExpr : BVLogicalExpr :=
  let x := BVExpr.const (BitVec.ofNat 64 2)
  let y := BVExpr.const (BitVec.ofNat 64 4)
  let z := BVExpr.var 0
  let sum := BVExpr.bin x BVBinOp.add y
  BoolExpr.literal (BVPred.bin sum BVBinPred.eq z)


syntax (name := testExFa) "test_exists_forall" : tactic
@[tactic testExFa]
def testExFaImpl : Tactic := fun _ => do
  let res ← solver bvExpr
  match res with
    | none => pure ()
    | some counterex =>
        for (id, var) in counterex do
          logInfo m! "Results: {id}={var.bv}"
  pure ()

theorem test : False := by
  test_exists_forall


structure Solver where
  constraints : IO.Ref (List BVLogicalExpr)
  modelRef : IO.Ref (Std.HashMap Expr BVExpr.PackedBitVec)

namespace Solver

def new : IO Solver := do
  let constraints ← IO.mkRef ([] : List BVLogicalExpr)
  let modelRef ← IO.mkRef ({} : Std.HashMap Expr BVExpr.PackedBitVec)
  return { constraints, modelRef }

def add (s : Solver) (expr : BVLogicalExpr) : IO Unit := do
  s.constraints.modify (λ cs => expr :: cs)


def generateModel (s : Solver) : IO (Std.HashMap Expr BVExpr.PackedBitVec) := do
  --TODO
  return {}

def check (s : Solver) : IO Bool := do
  --TODO: Invoke the solver function and update the model
  return True


def model (s : Solver) : IO (Std.HashMap Expr BVExpr.PackedBitVec) := do
  s.modelRef.get

end Solver

def substitute (bvExpr: BVLogicalExpr) (subst: Std.HashMap Expr BVExpr.PackedBitVec) : BVLogicalExpr :=
  --TODO
  bvExpr

structure ExistsForAllConfig where
  expr : BVLogicalExpr
  existsVars : List Expr
  forAllVars : List Expr

def existsForAll (cfg: ExistsForAllConfig) : IO (Option (Std.HashMap Expr BVExpr.PackedBitVec)) := do
  let eSolver ← Solver.new
  eSolver.add cfg.expr

  let rec helper : IO (Option (Std.HashMap Expr BVExpr.PackedBitVec)) := do
    let eSat ← eSolver.check
    if !eSat then
      logInfo s! "Could not satisfy exists formula for {cfg.expr}"
      return none

    let eModel ← eSolver.model
    let eVals := eModel.filter fun (c, _) => cfg.existVars.contains c

    let substExpr := substitute cfg.expr eVals

    let fSolver ← Solver.new
    fSolver.add (BoolExpr.not substExpr)

    let fSat ← fSolver.check
    if !fSat then
      logInfo s! "Found solution"
      return some eVals


    let fModel ← fSolver.model
    let counterExamples := fModel.filter fun (c, _) => cfg.forAllVars.contains c

    let substExpr' := substitute cfg.expr counterExamples
    eSolver.add substExpr'

    helper

  helper
