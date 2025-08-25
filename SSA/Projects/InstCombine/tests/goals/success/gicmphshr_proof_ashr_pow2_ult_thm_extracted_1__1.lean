
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem ashr_pow2_ult_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬x ≥ ↑8 → True ∧ BitVec.ofInt 8 (-128) >>> x <<< x ≠ BitVec.ofInt 8 (-128) ∨ x ≥ ↑8 → False :=
sorry