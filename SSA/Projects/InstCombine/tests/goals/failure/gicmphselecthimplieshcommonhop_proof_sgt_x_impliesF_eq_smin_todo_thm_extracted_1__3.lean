
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem sgt_x_impliesF_eq_smin_todo_thm.extracted_1._3 : ∀ (x x_1 x_2 : BitVec 8),
  ofBool (x_1 <ₛ x_2) = 1#1 → ofBool (x_2 ≤ₛ x_1) = 1#1 → ofBool (BitVec.ofInt 8 (-128) == x_2) = ofBool (x == x_2) :=
sorry