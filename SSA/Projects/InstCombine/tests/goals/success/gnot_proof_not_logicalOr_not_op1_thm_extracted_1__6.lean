
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem not_logicalOr_not_op1_thm.extracted_1._6 : ∀ (x x_1 : BitVec 1),
  ¬x_1 = 1#1 → ¬x_1 ^^^ 1#1 = 1#1 → x ^^^ 1#1 ^^^ 1#1 = 0#1 :=
sorry