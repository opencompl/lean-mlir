
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem select_zext_different_condition_thm.extracted_1._2 : ∀ (x x_1 : BitVec 1),
  ¬x_1 = 1#1 →
    True ∧ (1#64).saddOverflow (zeroExtend 64 x) = true ∨ True ∧ (1#64).uaddOverflow (zeroExtend 64 x) = true → False :=
sorry