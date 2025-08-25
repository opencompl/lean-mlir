
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test14_thm.extracted_1._2 : ∀ (x x_1 : BitVec 32),
  ¬(8#32 ≥ ↑32 ∨ 8#32 ≥ ↑32) →
    ¬8#32 ≥ ↑32 → (x_1 <<< 8#32 - x &&& 128#32) * x_1 <<< 8#32 = (0#32 - x &&& 128#32) * x_1 <<< 8#32 :=
sorry