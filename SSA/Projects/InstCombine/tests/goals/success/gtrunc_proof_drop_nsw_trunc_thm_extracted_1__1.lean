
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem drop_nsw_trunc_thm.extracted_1._1 : ∀ (x x_1 : BitVec 16),
  ¬(True ∧ signExtend 16 (truncate 8 (x_1 &&& 255#16 &&& x)) ≠ x_1 &&& 255#16 &&& x) →
    truncate 8 (x_1 &&& 255#16 &&& x) = truncate 8 (x_1 &&& x) :=
sorry