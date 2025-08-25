
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem mismatched_shifts_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬(x ≥ ↑8 ∨ x + 1#8 ≥ ↑8) → x ≥ ↑8 ∨ x + 1#8 ≥ ↑8 ∨ True ∧ (16#8 <<< x &&& 3#8 >>> (x + 1#8) != 0) = true → False :=
sorry