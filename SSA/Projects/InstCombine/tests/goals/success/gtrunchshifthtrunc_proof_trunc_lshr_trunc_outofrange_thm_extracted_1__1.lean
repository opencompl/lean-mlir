
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem trunc_lshr_trunc_outofrange_thm.extracted_1._1 : ∀ (x : BitVec 64),
  ¬25#32 ≥ ↑32 →
    25#32 ≥ ↑32 ∨
        True ∧ signExtend 32 (truncate 8 (truncate 32 x >>> 25#32)) ≠ truncate 32 x >>> 25#32 ∨
          True ∧ zeroExtend 32 (truncate 8 (truncate 32 x >>> 25#32)) ≠ truncate 32 x >>> 25#32 →
      False :=
sorry