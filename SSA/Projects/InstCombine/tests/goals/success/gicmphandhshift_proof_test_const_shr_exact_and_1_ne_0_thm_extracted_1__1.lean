
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test_const_shr_exact_and_1_ne_0_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬(True ∧ 42#32 >>> x <<< x ≠ 42#32 ∨ x ≥ ↑32) → True ∧ 1#32 <<< x >>> x ≠ 1#32 ∨ x ≥ ↑32 → False :=
sorry