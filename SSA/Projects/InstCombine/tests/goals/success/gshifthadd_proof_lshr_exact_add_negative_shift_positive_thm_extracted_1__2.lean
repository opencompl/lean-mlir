
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem lshr_exact_add_negative_shift_positive_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬(True ∧ 2#32 >>> (x + -1#32) <<< (x + -1#32) ≠ 2#32 ∨ x + -1#32 ≥ ↑32) →
    ¬(True ∧ 4#32 >>> x <<< x ≠ 4#32 ∨ x ≥ ↑32) → 2#32 >>> (x + -1#32) = 4#32 >>> x :=
sorry