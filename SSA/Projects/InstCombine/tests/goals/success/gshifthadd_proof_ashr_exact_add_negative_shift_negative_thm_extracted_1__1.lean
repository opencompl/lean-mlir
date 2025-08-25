
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem ashr_exact_add_negative_shift_negative_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬(True ∧ BitVec.ofInt 32 (-2) >>> (x + -1#32) <<< (x + -1#32) ≠ BitVec.ofInt 32 (-2) ∨ x + -1#32 ≥ ↑32) →
    True ∧ BitVec.ofInt 32 (-4) >>> x <<< x ≠ BitVec.ofInt 32 (-4) ∨ x ≥ ↑32 → False :=
sorry