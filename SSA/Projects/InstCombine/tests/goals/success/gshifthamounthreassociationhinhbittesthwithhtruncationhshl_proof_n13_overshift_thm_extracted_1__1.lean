
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem n13_overshift_thm.extracted_1._1 : ∀ (x : BitVec 64) (x_1 x_2 : BitVec 32),
  ¬(32#32 - x_1 ≥ ↑32 ∨ zeroExtend 64 (x_1 + 32#32) ≥ ↑64) →
    32#32 - x_1 ≥ ↑32 ∨ True ∧ (x_1 + 32#32).msb = true ∨ zeroExtend 64 (x_1 + 32#32) ≥ ↑64 → False :=
sorry