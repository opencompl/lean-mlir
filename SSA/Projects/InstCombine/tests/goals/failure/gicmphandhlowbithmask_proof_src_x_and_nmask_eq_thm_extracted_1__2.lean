
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem src_x_and_nmask_eq_thm.extracted_1._2 : ∀ (x : BitVec 8) (x_1 : BitVec 1),
  ¬x_1 = 1#1 →
    ¬x_1 ^^^ 1#1 = 1#1 →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 1)) (self :=
        @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
        (PoisonOr.value (ofBool (0#8 == x &&& 0#8))) PoisonOr.poison :=
sorry