
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem urem_i32_c_multiuse_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬10#32 = 0 →
    10#32 = 0 ∨
        True ∧ (zeroExtend 32 x % 10#32).saddOverflow (zeroExtend 32 x) = true ∨
          True ∧ (zeroExtend 32 x % 10#32).uaddOverflow (zeroExtend 32 x) = true →
      False :=
sorry