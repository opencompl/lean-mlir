
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬(17#32 ≥ ↑32 ∨ 17#32 ≥ ↑32) →
    31#32 ≥ ↑32 →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 32)) (self :=
        @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
        (PoisonOr.value ((x.sshiftRight' 17#32).sshiftRight' 17#32)) PoisonOr.poison :=
sorry