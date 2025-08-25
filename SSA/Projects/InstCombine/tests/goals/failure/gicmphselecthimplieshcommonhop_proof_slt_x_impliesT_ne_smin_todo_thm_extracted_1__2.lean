
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem slt_x_impliesT_ne_smin_todo_thm.extracted_1._2 : ∀ (x x_1 x_2 : BitVec 8),
  ofBool (x_2 <ₛ x_1) = 1#1 → ofBool (x_2 != 127#8) = 1#1 :=
sorry