
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem trunc_sandwich_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬(28#32 ≥ ↑32 ∨ 2#12 ≥ ↑12) →
    30#32 ≥ ↑32 ∨
        True ∧ signExtend 32 (truncate 12 (x >>> 30#32)) ≠ x >>> 30#32 ∨
          True ∧ zeroExtend 32 (truncate 12 (x >>> 30#32)) ≠ x >>> 30#32 →
      False :=
sorry