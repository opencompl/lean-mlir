
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem udiv2_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ¬(x ≥ ↑32 ∨ True ∧ x_1.umod (1#32 <<< x) ≠ 0 ∨ 1#32 <<< x = 0) → True ∧ x_1 >>> x <<< x ≠ x_1 ∨ x ≥ ↑32 → False :=
sorry