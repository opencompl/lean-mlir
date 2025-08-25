
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem trunc_lshr_big_mask_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬2#8 ≥ ↑8 → 2#8 ≥ ↑8 ∨ True ∧ zeroExtend 8 (truncate 6 (x >>> 2#8)) ≠ x >>> 2#8 → False :=
sorry