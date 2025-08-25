
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem src_is_mask_select_thm.extracted_1._2 : ∀ (x x_1 : BitVec 8) (x_2 : BitVec 1),
  x_2 = 1#1 →
    ofBool ((x_1 ^^^ x_1 + -1#8) &&& (x ^^^ 123#8) != x ^^^ 123#8) = ofBool (x_1 ^^^ x_1 + -1#8 <ᵤ x ^^^ 123#8) :=
sorry