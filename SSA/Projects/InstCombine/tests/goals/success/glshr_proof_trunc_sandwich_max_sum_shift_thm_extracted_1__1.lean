
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem trunc_sandwich_max_sum_shift_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬(20#32 ≥ ↑32 ∨ 11#12 ≥ ↑12) →
    31#32 ≥ ↑32 ∨
        True ∧ signExtend 32 (truncate 12 (x >>> 31#32)) ≠ x >>> 31#32 ∨
          True ∧ zeroExtend 32 (truncate 12 (x >>> 31#32)) ≠ x >>> 31#32 →
      False :=
sorry