
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem t3_thm.extracted_1._2 : ∀ (x : BitVec 32) (x_1 : BitVec 64),
  ¬(x ≥ ↑32 ∨ zeroExtend 64 (4#32 <<< x) = 0) →
    ¬(True ∧ (x + 2#32).msb = true ∨ zeroExtend 64 (x + 2#32) ≥ ↑64) →
      x_1 / zeroExtend 64 (4#32 <<< x) = x_1 >>> zeroExtend 64 (x + 2#32) :=
sorry