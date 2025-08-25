
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem PR30273_three_bools_thm.extracted_1._5 : ∀ (x x_1 x_2 : BitVec 1),
  x_2 = 1#1 →
    ¬x_1 = 1#1 →
      ¬(True ∧ (zeroExtend 32 x).saddOverflow 1#32 = true) →
        True ∧ (zeroExtend 32 x).saddOverflow (zeroExtend 32 x_2) = true ∨
            True ∧ (zeroExtend 32 x).uaddOverflow (zeroExtend 32 x_2) = true →
          False :=
sorry