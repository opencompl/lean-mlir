
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test13_thm.extracted_1._2 : ∀ (x x_1 : BitVec 32),
  ¬(8#32 ≥ ↑32 ∨ 8#32 ≥ ↑32) →
    ¬8#32 ≥ ↑32 → (x_1 - x <<< 8#32 &&& 128#32) * x <<< 8#32 = (x_1 &&& 128#32) * x <<< 8#32 :=
sorry