
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem src_x_and_nmask_ne_thm.extracted_1._4 : ∀ (x : BitVec 8) (x_1 : BitVec 1) (x_2 : BitVec 8),
  ¬x_1 = 1#1 → ofBool (x_2 &&& 0#8 != 0#8) = 0#1 :=
sorry