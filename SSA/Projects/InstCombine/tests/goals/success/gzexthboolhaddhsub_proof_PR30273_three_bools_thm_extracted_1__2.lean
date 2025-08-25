
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem PR30273_three_bools_thm.extracted_1._2 : ∀ (x x_1 x_2 : BitVec 1),
  x_2 = 1#1 →
    x_1 = 1#1 →
      ¬(True ∧ (zeroExtend 32 x).saddOverflow 1#32 = true) →
        x = 1#1 →
          ¬(True ∧ (zeroExtend 32 x + 1#32).saddOverflow 1#32 = true) →
            ¬(True ∧ (2#32).saddOverflow (zeroExtend 32 x_2) = true ∨
                  True ∧ (2#32).uaddOverflow (zeroExtend 32 x_2) = true) →
              zeroExtend 32 x + 1#32 + 1#32 = 2#32 + zeroExtend 32 x_2 :=
sorry