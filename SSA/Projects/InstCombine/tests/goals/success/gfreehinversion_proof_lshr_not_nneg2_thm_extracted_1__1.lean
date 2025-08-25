
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem lshr_not_nneg2_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬1#8 ≥ ↑8 → 1#8 ≥ ↑8 ∨ True ∧ (x >>> 1#8 &&& BitVec.ofInt 8 (-128) != 0) = true → False :=
sorry