
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem and_xor_or4_thm.extracted_1._2 : ∀ (x x_1 x_2 : BitVec 64),
  ¬(x_2 = 0 ∨ x_1 = 0 ∨ x = 0 ∨ x_1 = 0) →
    ¬(x_2 = 0 ∨ x_1 = 0) → 42#64 / x_2 ^^^ 42#64 / x_1 &&& 42#64 / x ||| 42#64 / x_1 = 42#64 / x_2 ||| 42#64 / x_1 :=
sorry