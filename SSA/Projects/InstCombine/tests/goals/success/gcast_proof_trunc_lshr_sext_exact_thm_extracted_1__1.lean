
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem trunc_lshr_sext_exact_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬(True ∧ signExtend 32 x >>> 6#32 <<< 6#32 ≠ signExtend 32 x ∨ 6#32 ≥ ↑32) →
    True ∧ x >>> 6#8 <<< 6#8 ≠ x ∨ 6#8 ≥ ↑8 → False :=
sorry