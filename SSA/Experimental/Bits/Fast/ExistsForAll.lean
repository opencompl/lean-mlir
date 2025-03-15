
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


def solver (bvExpr: BVLogicalExpr) : TermElabM (Option (Std.HashMap Expr BVExpr.PackedBitVec)) := do
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
        -- let equations := reconstructCounterExample map assignment entry.aig.decls.size atomsAssignment
        return .some assignment

def bvExpr : BVLogicalExpr :=
  let x := BVExpr.const (BitVec.ofNat 64 2)
  let y := BVExpr.const (BitVec.ofNat 64 4)
  let z := BVExpr.const (BitVec.ofNat 64 8)
  let sum := BVExpr.bin x BVBinOp.add y
  BoolExpr.literal (BVPred.bin sum BVBinPred.eq z)


#eval solver bvExpr


-- def model' (bvExpr: BVLogicalExpr) : TermElabM (Option (Array (Bool × Nat))) := do
--   match ← solver bvExpr with
--   | .error as => pure (some as)
--   | _ => pure none

-- def model'' (bvExpr: BVLogicalExpr) : TermElabM Expr :=  do
--   let _ ← model' bvExpr
--   return default

-- def test := model'' bvExpr

-- #eval solver bvExpr
