
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem t0_thm.extracted_1._1 : ∀ (x : BitVec 16) (x_1 : BitVec 32),
  ¬(zeroExtend 32 (32#16 - x) ≥ ↑32 ∨ x + -1#16 ≥ ↑16) →
    31#32 ≥ ↑32 ∨
        True ∧ signExtend 32 (truncate 16 (x_1 >>> 31#32)) ≠ x_1 >>> 31#32 ∨
          True ∧ zeroExtend 32 (truncate 16 (x_1 >>> 31#32)) ≠ x_1 >>> 31#32 →
      False :=
sorry