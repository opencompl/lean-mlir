
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem lshr_add_and_shl_thm.extracted_1._2 : ∀ (x x_1 : BitVec 32),
  ¬(5#32 ≥ ↑32 ∨ 5#32 ≥ ↑32) →
    ¬5#32 ≥ ↑32 → (x_1 + (x >>> 5#32 &&& 127#32)) <<< 5#32 = (x &&& 4064#32) + x_1 <<< 5#32 :=
sorry