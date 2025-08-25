
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test_mul_nuw_nsw__none_are_safe_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (x == 805306368#32) = 1#1 → BitVec.ofInt 32 (-1342177280) = x * 9#32 :=
sorry