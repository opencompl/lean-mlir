
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem and_or2_wrong_operand_thm.extracted_1._3 : ∀ (x x_1 x_2 x_3 : BitVec 1),
  (x_3 ^^^ 1#1) &&& x_2 = 1#1 → ¬x_2 &&& (x_3 ^^^ 1#1) = 1#1 → x_1 = x :=
sorry