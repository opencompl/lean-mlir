
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem trunc_lshr_thm.extracted_1._2 : ∀ (x : BitVec 8),
  ¬2#8 ≥ ↑8 → ¬2#6 ≥ ↑6 → truncate 6 (x >>> 2#8) &&& 14#6 = truncate 6 x >>> 2#6 &&& 14#6 :=
sorry