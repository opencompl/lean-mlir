
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem xor_and_thm.extracted_1._4 : ∀ (x : BitVec 32) (x_1 : BitVec 1),
  ¬x_1 = 1#1 →
    ¬x_1 ^^^ 1#1 = 1#1 →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 1)) (self :=
        @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
        (PoisonOr.value (0#1 ^^^ 1#1)) PoisonOr.poison :=
sorry