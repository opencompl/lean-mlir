
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem not_mul_of_bool_thm.extracted_1._1 : ∀ (x : BitVec 8) (x_1 : BitVec 32),
  True ∧ (x_1 &&& 3#32).smulOverflow (zeroExtend 32 x) = true ∨
      True ∧ (x_1 &&& 3#32).umulOverflow (zeroExtend 32 x) = true →
    False :=
sorry