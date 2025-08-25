
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem n14_trunc_of_lshr_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32) (x_2 : BitVec 64),
  ¬(zeroExtend 64 (32#32 - x_1) ≥ ↑64 ∨ x_1 + -1#32 ≥ ↑32) →
    x_1 + -1#32 ≥ ↑32 ∨ True ∧ (32#32 - x_1).msb = true ∨ zeroExtend 64 (32#32 - x_1) ≥ ↑64 → False :=
sorry