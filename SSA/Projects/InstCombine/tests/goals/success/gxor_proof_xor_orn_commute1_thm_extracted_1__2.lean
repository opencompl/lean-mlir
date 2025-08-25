
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem xor_orn_commute1_thm.extracted_1._2 : ∀ (x x_1 : BitVec 8),
  ¬(x_1 = 0 ∨ x_1 = 0) → ¬x_1 = 0 → 42#8 / x_1 ^^^ (42#8 / x_1 ^^^ -1#8 ||| x) = 42#8 / x_1 &&& x ^^^ -1#8 :=
sorry