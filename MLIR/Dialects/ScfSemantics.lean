import MLIR.Semantics.Fitree
import MLIR.Semantics.Semantics
import MLIR.Semantics.SSAEnv
import MLIR.Semantics.UB
import MLIR.Util.Metagen
import MLIR.AST
import MLIR.EDSL
import Mathlib.Data.List.Dedup
open MLIR.AST

/-
### Dialect: `scf`
-/

instance scf: Dialect Void Void (fun _x => Unit) where
  name := "scf"
  iα := inferInstance
  iε := inferInstance

-- Operations of `scf` that unfold into regions need to expose these regions
-- | run a loop, decrementing i from n to -
-- | ix := lo + (n - i) * step
def run_loop_bounded_stepped_go [Monad m] (n: Nat) (i: Nat) (lo: Int) (step: Int)
  (accum: a) (eff: Int -> a -> m a): m a := do
   let ix : Int := lo + (n - i) * step
   let accum <- eff ix accum
   match i with
   | .zero => return accum
   | .succ i' => run_loop_bounded_stepped_go n i' lo step accum eff

-- | TODO: make this model the `yield` as well.
def run_loop_bounded_stepped [Monad m] (n: Nat) (lo: Int) (step: Int) (accum: a) (eff: Int -> a -> m a): m a :=
  run_loop_bounded_stepped_go n n lo step accum eff


-- | TODO: make this model the `yield` as well.
def run_loop_bounded
  (n: Nat)
  (ix: Int)
  (start: TypedArgs Δ)
  (rgn: TypedArgs Δ → OpM Δ (TypedArgs Δ)): OpM Δ (TypedArgs Δ):= do
  match n with
  | 0 => return start
  | .succ n' => do
    let (_: TypedArgs Δ) <- rgn [⟨MLIRType.index, ix⟩]
    run_loop_bounded n' (ix + 1) ([]) rgn


-- | TODO: refactor to (1) an effect, (2) an interpretation
-- | TODO: use the return type of Scf.For. For now, just do unit.
def scf_semantics_op: IOp Δ → OpM Δ (TypedArgs Δ)
  | IOp.mk "scf.if" _ [⟨.i1, b⟩]  [rthen, relse] _ => do
      (if b = 1 then rthen else relse) []
  | IOp.mk "scf.for" _ [⟨.index, lo⟩, ⟨.index, hi⟩, ⟨.index, step⟩] [body] _ => do
    let nsteps : Int := (hi - lo) / step
    let _  ← run_loop_bounded_stepped
      (a := TypedArgs Δ)
      (n := nsteps.toNat)
      (lo := lo)
      (step := step)
      (accum := default)
      (eff := (fun i _ => body [⟨.index, i⟩]))
    return []
  | IOp.mk "scf.for'" _ [⟨.index, lo⟩, ⟨.index, hi⟩] [body] _ => do
      run_loop_bounded (n := (hi - lo).toNat) (ix := lo) [] body
  | IOp.mk "scf.yield" _ vs [] _ =>
      return vs
  | IOp.mk "scf.assert" _ [⟨.i1, arg⟩] [] attrs =>
    if arg  == 0 then
      let err := match attrs.find "msg" with -- TODO: convert this to a pattern match.
          | .some (.str str) => str
          | _ => ""
      OpM.Error s!"{err}: {arg} <assert failed>"
    else return [] -- success
  | IOp.mk "scf.execute_region" _ args  [rgn] _ => do
      rgn args
  | IOp.mk name .. => OpM.Unhandled ("scf unhandled: " ++ name)

instance: Semantics scf where
  semantics_op := scf_semantics_op

/-
### Theorems
-/

namespace SCF.IF
-- Proof that `scf.if` with a fixed condition simplifies to its "then" or
-- "else" region depending on the value

def LHS (r₁ r₂: Region scf): Region scf := [mlir_region|
{
  "scf.if" (%b) ($(r₁), $(r₂)) : (i1) -> ()
}]

def INPUT (b: Bool): SSAEnv scf :=
  SSAEnv.set "b" MLIRType.i1 (if b then 1 else 0) SSAEnv.empty


-- Pure unfolding-style proof
theorem equivalent (b: Bool):
    run ⟦LHS r₁ r₂⟧ (INPUT b) =
    run (TopM.scoped (denoteRegion
          (Δ := scf)
          (rgn := if b then r₁ else r₂)
          (args := []))) (INPUT b) := by
    simp[LHS];
    simp[run_denoteRegion];
    simp[run_bind_success];
    rw[run_seq];
    simp[run_denoteTypedArgs_nil];
    simp [run_denoteOps_singleton];
    simp[run_denoteOp];
    simp[run_bind];
    simp[run_denoteOp];
    simp[run_denoteOpArgs_cons_];
    simp[run_bind];
    simp[INPUT];
    rw[run_TopM_get_];
    simp[SSAEnv.get_set_eq];
    simp[run_denoteOpArgs_nil];
    simp[run_pure];
    simp[INPUT];
    simp[TopM.mapDenoteRegion]; -- TODO: make run version of this
    save
    simp[OpM.denoteRegions] -- TODO: make run version
    simp[Semantics.semantics_op]; -- TODO: make run version
    simp[scf_semantics_op]; -- SLOW
    save
    -- VERY SLOW
    cases b <;> simp;
    case false => {
      rw[OpM_toTopM_denoteRegion]; -- TODO: make run version
      simp[TopM.denoteRegionsByIx]; -- TODO: make run version
    }
    case true => {
      -- TODO, FIXME, BUG: lean does not unfold the definition in the
      -- 'true' branch, while it does on the 'false' branch.
      -- This seems to be a tactic bug, because even after
      -- 'sorry'ing, we still get an error.
      sorry
      /-
      rw[OpM_toTopM_denoteRegion];
      simp[TopM.denoteRegionsByIx];
      -/
    }
    -- | but having this sorry here fixes the 'case true' error,
    -- even though lean knows that this tactic in unreachable:
    --   'this tactic is never executed [linter.unreachableTactic]'
    sorry

end SCF.IF



namespace SCF.FOR_PEELING
def LHS (r: Region scf): Region scf := [mlir_region|
{
  "scf.for'" (%c0, %cn_plus_1) ($(r)) : (index, index) -> ()
}]
def RHS  (r: Region scf): Region scf := [mlir_region|
{
  "scf.execute_region" (%c0) ($(r)) : (index) -> ()
  "scf.for'" (%c1, %cn_plus_1) ($(r)) : (index, index) -> ()
}]
def INPUT (n: Nat): SSAEnv scf :=
  SSAEnv.set "cn" .index n
    (SSAEnv.set "cn_plus_1" .index (n + 1)
      (SSAEnv.set "c0" .index 0
        (SSAEnv.set "c1" .index 1 SSAEnv.empty)))
/-
SSAEnv.One [
  ⟨"cn", .index, n⟩,
  ⟨"cn_plus_1", .index, n + 1⟩,
  ⟨"c0", .index, 0⟩,
  ⟨"c1", .index, 1⟩]
-/

 -- The main requirement for this theorem is that `r` satisfies SSA invariants,
-- ie. values available before it runs are unchanged by its execution. Here we
-- assume something quite a bit stronger, to simplify the proof of the actual
-- property, which is that a read can commute with running the region.


theorem CORRECT_r (n:Nat) (r: Region scf) args:
    (run (denoteRegion scf r args) (INPUT n)) = .ok ([], INPUT n) := by
   sorry

/-
theorem CORRECT_r_commute_run_interpRegion_SSAEnvE_get [S: Semantics scf]
  (CORRECT_r: (run (denoteRegion scf r args) (INPUT n)) = .ok (.Ret [], INPUT n))
  (name: SSAVal) (τ: MLIRType scf) (v: MLIRType.eval τ)
  (ENV: SSAEnv.get name τ (INPUT n) = some v)
  (k: BlockResult scf → τ.eval → Fitree (SSAEnvE scf +' UBE) R):
  run (Fitree.bind
    (interpRegion scf [denoteRegion scf r] _ (Sum.inl <| RegionE.RunRegion 0 args))
    (fun discr =>
      Fitree.Vis (Sum.inl <| SSAEnvE.Get τ name) fun v => k discr v)) (INPUT n) =
  run (Fitree.Vis (Sum.inl <| SSAEnvE.Get τ name) fun v =>
    (Fitree.bind (interpRegion scf [denoteRegion scf r] _ (Sum.inl <| RegionE.RunRegion 0 args))
    (fun discr => k discr v))) (INPUT n) := by
  simp [run_bind, interpRegion, List.get!]
  simp [CORRECT_r]
  simp [run_SSAEnvE_get _ _ _ _ _ ENV]
  simp [run_bind, CORRECT_r]
-/
private theorem identity₁ (n: Nat):
    Int.toNat (Int.ofNat n + 1 - 0) = n + 1 := by
  sorry


set_option maxHeartbeats 999999999 in
-- Pretty slow due to simplifying scf_semantics_op
-- which contains a large match
theorem equivalent (n: Nat) (r: Region scf):
    (run ⟦LHS r⟧ (INPUT n)) =
    (run ⟦RHS r⟧ (INPUT n)) := by {
   simp[LHS, RHS];
   simp[run_denoteRegion];
   simp[run_bind];
   simp[run_denoteTypedArgs_nil];
   simp[run_denoteOps_singleton];
   simp[run_denoteOp];
   simp[run_bind];
   simp[INPUT];
   simp[run_denoteOpArgs_cons_];
   simp[run_bind];
   rw[run_TopM_get_];
   rw[SSAEnv.get_set_ne_val];
   rw[SSAEnv.get_set_ne_val];
   rw[SSAEnv.get_set_eq_val] <;> simp;
   simp[run_denoteOpArgs_cons_];
   simp[run_bind];
   rw[run_TopM_get_];
   rw[SSAEnv.get_set_ne_val];
   rw[SSAEnv.get_set_eq_val] <;> simp;
   simp[run_denoteOpArgs_nil];
   simp[run_pure];
   simp[TopM.mapDenoteRegion]; -- TODO: make a 'run' version of this.
   simp[Semantics.semantics_op, scf_semantics_op]; -- SLOW :(
   simp[OpM.denoteRegions];
   apply Eq.symm;
   simp[run_denoteOps_cons];
   simp[run_bind];
   simp[run_denoteOps_singleton];
   simp[run_denoteOp];
   simp[run_bind];
   simp[run_denoteOpArgs_cons_];
   simp[run_bind];
   rw[run_TopM_get_];
   rw[SSAEnv.get_set_ne_val];
   rw[SSAEnv.get_set_ne_val];
   rw[SSAEnv.get_set_eq_val];
   simp;
   simp[run_denoteOpArgs_nil];
   simp[run_pure];
   simp[TopM_mapDenoteRegion_cons];
   simp[TopM_mapDenoteRegion_nil];
   simp[Semantics.semantics_op, scf_semantics_op];
   simp[OpM_denoteRegions_cons];
   save
   -- tactic 'simp' failed, nested error:
   -- (deterministic) timeout at 'whnf', maximum number of heartbeats (200000)
   -- has been reached (use 'set_option maxHeartbeats <num>' to set the limit)
   simp[OpM_denoteRegions_nil];
   simp[run_OpM_toTopM_denoteRegion];
   simp[run_TopM_denoteRegionsByIx_cons];
   sorry
   sorry
   simp; simp; simp; simp;
}

  /-
  simp [LHS, RHS]
  simp [denoteTypedArgs, denoteOps, denoteOp]
  simp [denoteOpBase, Semantics.semantics_op, scf_semantics_op]; simp_itree
  -/
  /-
  -- simp [denoteRegions]
  rw [run_SSAEnvE_get "c0" .index 0]
  rw [run_SSAEnvE_get "cn_plus_1" .index (n+1)]
  rw [run_SSAEnvE_get "c0" .index 0]
  have h := CORRECT_r n r [⟨.index, 0⟩]
  rw [CORRECT_r_commute_run_interpRegion_SSAEnvE_get h "c1" .index 1]
  rw [run_SSAEnvE_get "c1" .index 1]
  rw [CORRECT_r_commute_run_interpRegion_SSAEnvE_get h "cn_plus_1" .index (n+1)]
  rw [run_SSAEnvE_get "cn_plus_1" .index (n+1)]
  rw [identity₁]
  simp [(by sorry: (Int.ofNat n + 1 - 1).toNat = n)]
  simp [peel_run_loop_bounded, Fitree.interp_bind]
  simp [(by sorry: (0:Int) + (1:Int) = (1:Int))]
  all_goals simp [INPUT, cast_eq]
  -/
end SCF.FOR_PEELING


namespace SCF.FOR_FUSION
def LHS (r: Region scf): Region scf := [mlir_region|
{
  "scf.for'" (%c0, %cn) ($(r)) : (index, index) -> ()
  "scf.for'" (%cn, %cn_plus_m) ($(r)) : (index, index) -> ()
}]
def RHS (r: Region scf): Region scf := [mlir_region|
{
  "scf.for'" (%c0, %cn_plus_m) ($(r)) : (index, index) -> ()
}]
def INPUT (n m: Nat): SSAEnv scf := SSAEnv.One [
  ⟨"cn", .index, n⟩,
  ⟨"cn_plus_m", .index, n + m⟩,
  ⟨"c0", .index, 0⟩]

/- theorem interp_region_of_run_loop_bounded
  (r: Region scf) (n: Nat)
  (rhs: Fitree (SSAEnvE scf +' Semantics.E scf +' UBE) (BlockResult scf)):
    Fitree.interp (interpRegion scf (denoteRegions scf [r]))
      (run_loop_bounded n 0 (BlockResult.Ret [])) = rhs := by {
    induction n;
    case zero => {
      simp [run_loop_bounded];
      sorry
    }
    case succ n' => {
      simp [run_loop_bounded];
      simp [Fitree.interp];
      sorry
    }
   } -/
/-
theorem equivalent (n m: Nat) (r: Region scf):
    (run ⟦LHS r⟧ (INPUT n m)) =
    (run ⟦RHS r⟧ (INPUT n m)) := by
  simp [LHS, RHS, INPUT]
  simp [denoteRegion, denoteOps, denoteOp, denoteOpBase]
  simp_itree
  simp [Semantics.semantics_op, scf_semantics_op]
  simp [run];
  simp [StateT.run];
  simp [Except.bind];
  simp [denoteTypedArgs];
  simp [pure];
  simp [StateT.pure];
  simp [pure];
  simp [Except.pure];
  simp [List.mapM, List.mapM.loop];
  simp [bind, StateT.bind, Except.bind, TopM.get];
  sorry
  -- At this point we need something similar to CORRECT_r_* above.
  -- simp [run_denoteOp_interp_region]
  -- all_goals simp [INPUT, cast_eq]
-/
end SCF.FOR_FUSION
