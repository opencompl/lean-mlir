
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem or_trunc_lshr_small_mask_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬4#8 ≥ ↑8 →
    4#8 ≥ ↑8 ∨
        True ∧ signExtend 8 (truncate 6 (x >>> 4#8)) ≠ x >>> 4#8 ∨
          True ∧ zeroExtend 8 (truncate 6 (x >>> 4#8)) ≠ x >>> 4#8 →
      False :=
sorry