
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem ashr_lshr_cst2_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬ofBool (-1#32 <ₛ x) = 1#1 → ¬(True ∧ x >>> 8#32 <<< 8#32 ≠ x ∨ 8#32 ≥ ↑32) → 8#32 ≥ ↑32 → False :=
sorry