
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test_invalid_simplify_select_1_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬ofBool (x == 0#8) = 1#1 → x - 1#8 = x + -1#8 :=
sorry