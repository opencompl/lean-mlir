
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem sdiv_common_dividend_defined_cond_thm.extracted_1._2 : ∀ (x x_1 : BitVec 5) (x_2 : BitVec 1),
  ¬(x_2 = 1#1 ∨ (x == 0 || 5 != 1 && x_1 == intMin 5 && x == -1) = true) →
    ¬x_2 = 1#1 → (x == 0 || 5 != 1 && x_1 == intMin 5 && x == -1) = true → False :=
sorry