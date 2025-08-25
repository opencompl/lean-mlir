
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test_thm.extracted_1._1 : ∀ (x : BitVec 64),
  ¬(16#64 ≥ ↑64 ∨ 16#64 ≥ ↑64) →
    16#64 ≥ ↑64 ∨ True ∧ x <<< 16#64 >>> 16#64 <<< 16#64 ≠ x <<< 16#64 ∨ 16#64 ≥ ↑64 →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 64)) (self :=
        @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
        (PoisonOr.value ((x <<< 16#64).sshiftRight' 16#64)) PoisonOr.poison :=
sorry