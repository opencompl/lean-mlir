
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem shl_trunc_smaller_shl_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬(2#32 ≥ ↑32 ∨ 4#8 ≥ ↑8) → ¬6#8 ≥ ↑8 → truncate 8 (x <<< 2#32) <<< 4#8 = truncate 8 x <<< 6#8 :=
sorry