
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem simplify_and_common_op_commute1_thm.extracted_1._1 : ∀ (x x_1 x_2 : BitVec 4),
  ((x_2 ||| x_1 ||| x) ^^^ -1#4) &&& x_1 = 0#4 :=
sorry