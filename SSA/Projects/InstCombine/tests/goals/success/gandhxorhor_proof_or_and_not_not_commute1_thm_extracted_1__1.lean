
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem or_and_not_not_commute1_thm.extracted_1._1 : ∀ (x x_1 x_2 : BitVec 32),
  ¬((x_2 == 0 || 32 != 1 && 42#32 == intMin 32 && x_2 == -1) = true ∨
        (x_2 == 0 || 32 != 1 && 42#32 == intMin 32 && x_2 == -1) = true) →
    (x_2 == 0 || 32 != 1 && 42#32 == intMin 32 && x_2 == -1) = true → False :=
sorry