
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem trunc_nuw_xor_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  ¬(True ∧ zeroExtend 8 (truncate 1 (x_1 ^^^ x)) ≠ x_1 ^^^ x) → truncate 1 (x_1 ^^^ x) = ofBool (x_1 != x) :=
sorry