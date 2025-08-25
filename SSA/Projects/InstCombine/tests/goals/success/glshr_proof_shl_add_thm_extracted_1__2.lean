
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem shl_add_thm.extracted_1._2 : ∀ (x x_1 : BitVec 8),
  ¬(2#8 ≥ ↑8 ∨ 2#8 ≥ ↑8) → ¬2#8 ≥ ↑8 → (x_1 <<< 2#8 + x) >>> 2#8 = x >>> 2#8 + x_1 &&& 63#8 :=
sorry