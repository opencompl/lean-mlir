
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem shl_add_and_lshr_thm.extracted_1._2 : ∀ (x x_1 : BitVec 32),
  ¬(4#32 ≥ ↑32 ∨ 4#32 ≥ ↑32) → ¬4#32 ≥ ↑32 → ((x_1 >>> 4#32 &&& 8#32) + x) <<< 4#32 = (x_1 &&& 128#32) + x <<< 4#32 :=
sorry