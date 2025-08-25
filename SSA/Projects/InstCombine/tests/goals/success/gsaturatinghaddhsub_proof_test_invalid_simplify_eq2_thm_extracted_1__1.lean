
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test_invalid_simplify_eq2_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬ofBool (x == 2#8) = 1#1 → x - 1#8 = x + -1#8 :=
sorry