
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test_mul_nsw__nuw_is_safe_thm.extracted_1._3 : ∀ (x : BitVec 32),
  ¬ofBool (x &&& 268435457#32 == 268435456#32) = 1#1 →
    ¬(True ∧ (x &&& 268435457#32).smulOverflow 9#32 = true) →
      True ∧ (x &&& 268435457#32).umulOverflow 9#32 = true → False :=
sorry