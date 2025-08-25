
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem trunc_sandwich_max_sum_shift2_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬(30#32 ≥ ↑32 ∨ 1#12 ≥ ↑12) →
    ¬(31#32 ≥ ↑32 ∨
          True ∧ signExtend 32 (truncate 12 (x >>> 31#32)) ≠ x >>> 31#32 ∨
            True ∧ zeroExtend 32 (truncate 12 (x >>> 31#32)) ≠ x >>> 31#32) →
      truncate 12 (x >>> 30#32) >>> 1#12 = truncate 12 (x >>> 31#32) :=
sorry