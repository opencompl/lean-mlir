
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem sgt_x_impliesF_eq_smin_todo_thm.extracted_1._2 : ∀ (x x_1 : BitVec 8),
  ofBool (x <ₛ x_1) = 1#1 → ¬ofBool (x_1 ≤ₛ x) = 1#1 → ofBool (BitVec.ofInt 8 (-128) == x_1) = 0#1 :=
sorry