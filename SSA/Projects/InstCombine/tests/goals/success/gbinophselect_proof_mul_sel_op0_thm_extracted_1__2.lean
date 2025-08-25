
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem mul_sel_op0_thm.extracted_1._2 : ∀ (x : BitVec 32) (x_1 : BitVec 1),
  ¬x_1 = 1#1 → ¬(True ∧ (42#32).umod x ≠ 0 ∨ x = 0) → 42#32 / x * x = 42#32 :=
sorry