
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test6_thm.extracted_1._2 : ∀ (x : BitVec 64),
  ¬32#128 ≥ ↑128 →
    ¬(32#64 ≥ ↑64 ∨ True ∧ zeroExtend 64 (truncate 32 (x >>> 32#64)) ≠ x >>> 32#64) →
      truncate 32 (zeroExtend 128 x >>> 32#128) = truncate 32 (x >>> 32#64) :=
sorry