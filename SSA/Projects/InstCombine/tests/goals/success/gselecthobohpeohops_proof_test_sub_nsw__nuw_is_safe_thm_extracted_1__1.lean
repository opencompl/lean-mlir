
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test_sub_nsw__nuw_is_safe_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (x &&& 2147483647#32 == 1073741824#32) = 1#1 →
    True ∧ (BitVec.ofInt 32 (-2147483648)).usubOverflow (x &&& 2147483647#32) = true → False :=
sorry