
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem mul_add_to_mul_3_thm.extracted_1._1 : ∀ (x : BitVec 16),
  ¬(True ∧ (x * 2#16).saddOverflow (x * 3#16) = true) → x * 2#16 + x * 3#16 = x * 5#16 :=
sorry