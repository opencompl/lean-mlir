
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem t15_thm.extracted_1._2 : ∀ (x x_1 : BitVec 32),
  ¬(True ∧ x_1 <<< x >>> x ≠ x_1 ∨ x ≥ ↑32 ∨ x_1 = 0) →
    ¬(True ∧ 1#32 <<< x >>> x ≠ 1#32 ∨ x ≥ ↑32) → x_1 <<< x / x_1 = 1#32 <<< x :=
sorry