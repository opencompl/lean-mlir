
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem n10_ashr_lshr_thm.extracted_1._1 : ∀ (x : BitVec 16) (x_1 : BitVec 32),
  ¬(zeroExtend 32 (32#16 - x) ≥ ↑32 ∨ x + -1#16 ≥ ↑16) →
    True ∧ (32#16 - x).msb = true ∨ zeroExtend 32 (32#16 - x) ≥ ↑32 ∨ x + -1#16 ≥ ↑16 → False :=
sorry