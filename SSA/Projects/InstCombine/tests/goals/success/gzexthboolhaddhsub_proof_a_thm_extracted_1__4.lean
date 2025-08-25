
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem a_thm.extracted_1._4 : ∀ (x x_1 : BitVec 1),
  ¬x_1 = 1#1 →
    ¬(True ∧ (1#32).saddOverflow (signExtend 32 x) = true) →
      zeroExtend 32 x_1 + 1#32 + (0#32 - zeroExtend 32 x) = 1#32 + signExtend 32 x :=
sorry