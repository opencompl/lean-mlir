
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem and_not_or_commute1_thm.extracted_1._1 : ∀ (x x_1 x_2 : BitVec 32),
  ¬((x_1 == 0 || 32 != 1 && 42#32 == intMin 32 && x_1 == -1) = true ∨
        (x_1 == 0 || 32 != 1 && 42#32 == intMin 32 && x_1 == -1) = true) →
    (x_1 == 0 || 32 != 1 && 42#32 == intMin 32 && x_1 == -1) = true → False :=
sorry