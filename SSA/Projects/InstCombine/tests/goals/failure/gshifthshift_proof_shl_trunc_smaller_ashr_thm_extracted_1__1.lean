
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem shl_trunc_smaller_ashr_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬(10#32 ≥ ↑32 ∨ 13#24 ≥ ↑24) →
    3#24 ≥ ↑24 →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 24)) (self :=
        @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
        (PoisonOr.value (truncate 24 (x.sshiftRight' 10#32) <<< 13#24)) PoisonOr.poison :=
sorry