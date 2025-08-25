
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem and_xor_commute1_thm.extracted_1._2 : ∀ (x x_1 : BitVec 32),
  ¬(x_1 = 0 ∨ x_1 = 0 ∨ x = 0) →
    ¬(x_1 = 0 ∨ x = 0) → 42#32 / x_1 ^^^ 42#32 / x_1 &&& 42#32 / x = 42#32 / x_1 &&& (42#32 / x ^^^ -1#32) :=
sorry