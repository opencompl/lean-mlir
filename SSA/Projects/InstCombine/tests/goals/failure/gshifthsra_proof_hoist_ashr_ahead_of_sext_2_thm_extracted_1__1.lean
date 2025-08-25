
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem hoist_ashr_ahead_of_sext_2_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬8#32 ≥ ↑32 →
    7#8 ≥ ↑8 →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 32)) (self :=
        @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
        (PoisonOr.value ((signExtend 32 x).sshiftRight' 8#32)) PoisonOr.poison :=
sorry