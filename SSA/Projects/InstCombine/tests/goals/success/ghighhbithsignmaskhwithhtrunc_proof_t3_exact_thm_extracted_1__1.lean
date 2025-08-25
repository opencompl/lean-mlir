
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem t3_exact_thm.extracted_1._1 : ∀ (x : BitVec 64),
  ¬(True ∧ x >>> 63#64 <<< 63#64 ≠ x ∨ 63#64 ≥ ↑64) →
    True ∧ x >>> 63#64 <<< 63#64 ≠ x ∨
        63#64 ≥ ↑64 ∨
          True ∧ signExtend 64 (truncate 32 (x >>> 63#64)) ≠ x >>> 63#64 ∨
            True ∧ zeroExtend 64 (truncate 32 (x >>> 63#64)) ≠ x >>> 63#64 →
      False :=
sorry