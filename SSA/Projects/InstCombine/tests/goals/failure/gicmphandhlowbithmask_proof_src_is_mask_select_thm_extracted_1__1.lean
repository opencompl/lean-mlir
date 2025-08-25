
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem src_is_mask_select_thm.extracted_1._1 : ∀ (x : BitVec 8) (x_1 : BitVec 1),
  ¬x_1 = 1#1 → ofBool (15#8 &&& (x ^^^ 123#8) != x ^^^ 123#8) = ofBool (15#8 <ᵤ x ^^^ 123#8) :=
sorry