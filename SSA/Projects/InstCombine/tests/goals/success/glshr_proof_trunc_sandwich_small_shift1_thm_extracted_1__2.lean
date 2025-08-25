
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem trunc_sandwich_small_shift1_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬(19#32 ≥ ↑32 ∨ 1#12 ≥ ↑12) →
    ¬(20#32 ≥ ↑32 ∨ True ∧ zeroExtend 32 (truncate 12 (x >>> 20#32)) ≠ x >>> 20#32) →
      truncate 12 (x >>> 19#32) >>> 1#12 = truncate 12 (x >>> 20#32) &&& 2047#12 :=
sorry