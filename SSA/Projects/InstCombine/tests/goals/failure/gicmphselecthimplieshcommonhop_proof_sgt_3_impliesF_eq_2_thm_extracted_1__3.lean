
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem sgt_3_impliesF_eq_2_thm.extracted_1._3 : ∀ (x x_1 : BitVec 8),
  ofBool (3#8 <ₛ x_1) = 1#1 → ofBool (x_1 <ₛ 4#8) = 1#1 → ofBool (2#8 == x_1) = ofBool (x == x_1) :=
sorry