
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test4_thm.extracted_1._1 : ∀ (x x_1 : BitVec 9),
  True ∧ (zeroExtend 64 x_1).saddOverflow (zeroExtend 64 x) = true ∨
      True ∧ (zeroExtend 64 x_1).uaddOverflow (zeroExtend 64 x) = true →
    False :=
sorry