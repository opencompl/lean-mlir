
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem src_x_and_nmask_eq_thm.extracted_1._6 : ∀ (x x_1 : BitVec 8) (x_2 : BitVec 1),
  ¬x_2 = 1#1 → x_2 ^^^ 1#1 = 1#1 → ofBool (0#8 == x &&& 0#8) = 1#1 :=
sorry