
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem trunc_shl_ashr_infloop_thm.extracted_1._1 : ∀ (x : BitVec 64),
  ¬(3#64 ≥ ↑64 ∨ 2#64 ≥ ↑64) →
    1#64 ≥ ↑64 →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 32)) (self :=
        @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
        (PoisonOr.value (truncate 32 (x.sshiftRight' 3#64 <<< 2#64))) PoisonOr.poison :=
sorry