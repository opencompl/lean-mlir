
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test91_thm.extracted_1._1 : ∀ (x : BitVec 64),
  ¬48#96 ≥ ↑96 →
    48#96 ≥ ↑96 ∨
        True ∧ signExtend 96 (truncate 64 (signExtend 96 x >>> 48#96)) ≠ signExtend 96 x >>> 48#96 ∨
          True ∧ zeroExtend 96 (truncate 64 (signExtend 96 x >>> 48#96)) ≠ signExtend 96 x >>> 48#96 →
      False :=
sorry