
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem lshr_exact_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬(2#8 ≥ ↑8 ∨ 2#8 ≥ ↑8) → (x <<< 2#8 + 4#8) >>> 2#8 = x + 1#8 &&& 63#8 :=
sorry