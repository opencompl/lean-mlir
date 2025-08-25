
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem or_trunc_lshr_more_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬4#8 ≥ ↑8 → 4#6 ≥ ↑6 ∨ True ∧ (truncate 6 x >>> 4#6 &&& BitVec.ofInt 6 (-4) != 0) = true → False :=
sorry