
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem zext_ashr_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬2#16 ≥ ↑16 → 2#8 ≥ ↑8 ∨ True ∧ (x >>> 2#8 &&& x).msb = true → False :=
sorry