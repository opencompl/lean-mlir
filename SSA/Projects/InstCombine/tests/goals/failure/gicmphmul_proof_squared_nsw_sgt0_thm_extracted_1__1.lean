
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem squared_nsw_sgt0_thm.extracted_1._1 : ∀ (x : BitVec 5),
  ¬(True ∧ x.smulOverflow x = true) → ofBool (0#5 <ₛ x * x) = ofBool (x != 0#5) :=
sorry