
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem trunc_sandwich_min_shift1_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬(20#32 ≥ ↑32 ∨ 1#12 ≥ ↑12) →
    21#32 ≥ ↑32 ∨
        True ∧ signExtend 32 (truncate 12 (x >>> 21#32)) ≠ x >>> 21#32 ∨
          True ∧ zeroExtend 32 (truncate 12 (x >>> 21#32)) ≠ x >>> 21#32 →
      False :=
sorry