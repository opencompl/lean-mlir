
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem or_xor_commute4_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ¬(x_1 = 0 ∨ x = 0 ∨ x_1 = 0) → x = 0 ∨ x_1 = 0 → False :=
sorry