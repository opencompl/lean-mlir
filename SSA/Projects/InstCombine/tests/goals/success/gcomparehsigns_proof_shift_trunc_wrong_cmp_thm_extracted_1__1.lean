
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem shift_trunc_wrong_cmp_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬24#32 ≥ ↑32 → 24#32 ≥ ↑32 ∨ True ∧ zeroExtend 32 (truncate 8 (x >>> 24#32)) ≠ x >>> 24#32 → False :=
sorry