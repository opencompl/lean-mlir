
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test_add_nuw_nsw__nsw_is_safe_thm.extracted_1._3 : ∀ (x : BitVec 32),
  ¬ofBool (x ||| BitVec.ofInt 32 (-2147483648) == -1#32) = 1#1 →
    ¬(True ∧ (x ||| BitVec.ofInt 32 (-2147483648)).saddOverflow 1#32 = true ∨
          True ∧ (x ||| BitVec.ofInt 32 (-2147483648)).uaddOverflow 1#32 = true) →
      True ∧ (x ||| BitVec.ofInt 32 (-2147483648)).saddOverflow 1#32 = true → False :=
sorry