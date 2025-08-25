
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem p2_scalar_shifted_urem_by_const_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ¬(x ≥ ↑32 ∨ 3#32 = 0) → True ∧ (x_1 &&& 1#32) <<< x >>> x ≠ x_1 &&& 1#32 ∨ x ≥ ↑32 ∨ 3#32 = 0 → False :=
sorry