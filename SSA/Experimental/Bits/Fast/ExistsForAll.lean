
import Std.Sat.AIG.CNF
import Std.Sat.AIG.RelabelNat
import Std.Tactic.BVDecide.Bitblast.BVExpr
import Lean.Elab.Term
import Lean.Meta.ForEachExpr
import Lean.Meta.Tactic.Simp.BuiltinSimprocs.BitVec
import Lean

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


def substitute (bvExpr: BVLogicalExpr) (subst: Std.HashMap Expr BVExpr.PackedBitVec) : BVLogicalExpr :=
  --TODO
  bvExpr

def solver (bvExpr: BVLogicalExpr) : TermElabM (Option (Array (Bool × Nat))) := do
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
        -- let equations := reconstructCounterExample map assignment entry.aig.decls.size atomsAssignment --TODO: Extract counterexamples
        return .some assignment



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


def bvExpr : BVLogicalExpr :=
  let x := BVExpr.const (BitVec.ofNat 64 2)
  let y := BVExpr.const (BitVec.ofNat 64 2)
  let z := BVExpr.const (BitVec.ofNat 64 4)
  let sum := BVExpr.bin x BVBinOp.add y
  BoolExpr.literal (BVPred.bin sum BVBinPred.eq z)


syntax (name := testExFa) "test_exists_forall" : tactic
@[tactic testExFa]
def testExFaImpl : Tactic := fun _ => do
  let _ ← solver bvExpr
  pure ()

theorem test : False := by
  test_exists_forall
