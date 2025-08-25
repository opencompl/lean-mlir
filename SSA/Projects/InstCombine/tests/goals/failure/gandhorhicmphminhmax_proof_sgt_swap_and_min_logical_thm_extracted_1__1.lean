
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem sgt_swap_and_min_logical_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  ofBool (x_1 <ₛ x) = 1#1 → ofBool (x == BitVec.ofInt 8 (-128)) = 0#1 :=
sorry