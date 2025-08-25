
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test_add_nsw__nuw_is_safe_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ofBool (x &&& 2147483647#32 == 2147483647#32) = 1#1 →
    ¬(True ∧ (x &&& 2147483647#32).uaddOverflow 1#32 = true) →
      BitVec.ofInt 32 (-2147483648) = (x &&& 2147483647#32) + 1#32 :=
sorry