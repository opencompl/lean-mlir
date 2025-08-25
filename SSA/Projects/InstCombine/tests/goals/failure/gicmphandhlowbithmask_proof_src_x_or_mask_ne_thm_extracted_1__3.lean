
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem src_x_or_mask_ne_thm.extracted_1._3 : ∀ (x x_1 : BitVec 8) (x_2 : BitVec 1),
  ¬x_2 = 1#1 → ofBool (0#8 ||| x ^^^ -1#8 != -1#8) = ofBool (0#8 <ᵤ x) :=
sorry