
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem sgt_x_impliesF_eq_smin_todo_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  ofBool (x <ₛ x_1) = 1#1 →
    ofBool (x_1 ≤ₛ x) = 1#1 →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 1)) (self :=
        @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
        (PoisonOr.value (ofBool (BitVec.ofInt 8 (-128) == x_1))) PoisonOr.poison :=
sorry