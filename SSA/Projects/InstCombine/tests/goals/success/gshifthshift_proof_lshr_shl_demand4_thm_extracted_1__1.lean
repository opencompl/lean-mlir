
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem lshr_shl_demand4_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬(x ≥ ↑8 ∨ 3#8 ≥ ↑8) → x ≥ ↑8 ∨ 3#8 ≥ ↑8 ∨ True ∧ (60#8 >>> x <<< 3#8 &&& 7#8 != 0) = true → False :=
sorry