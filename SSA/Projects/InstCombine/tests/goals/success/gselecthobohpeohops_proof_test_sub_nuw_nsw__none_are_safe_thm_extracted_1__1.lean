
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test_sub_nuw_nsw__none_are_safe_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (x == 1#32) = 1#1 → 2147483647#32 = BitVec.ofInt 32 (-2147483648) - x :=
sorry