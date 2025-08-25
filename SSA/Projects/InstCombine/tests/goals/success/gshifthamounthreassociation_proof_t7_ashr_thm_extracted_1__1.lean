
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem t7_ashr_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ¬(True ∧ x_1 >>> (32#32 - x) <<< (32#32 - x) ≠ x_1 ∨ 32#32 - x ≥ ↑32 ∨ x + BitVec.ofInt 32 (-2) ≥ ↑32) →
    30#32 ≥ ↑32 → False :=
sorry