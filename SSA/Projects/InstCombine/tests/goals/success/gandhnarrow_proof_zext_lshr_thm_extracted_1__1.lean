
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem zext_lshr_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬4#16 ≥ ↑16 → 4#8 ≥ ↑8 ∨ True ∧ (x >>> 4#8 &&& x).msb = true → False :=
sorry