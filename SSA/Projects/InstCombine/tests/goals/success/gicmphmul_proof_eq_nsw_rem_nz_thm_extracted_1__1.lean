
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem eq_nsw_rem_nz_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬(True ∧ x.smulOverflow 5#8 = true) → ofBool (x * 5#8 == BitVec.ofInt 8 (-11)) = 0#1 :=
sorry