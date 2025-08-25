
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem eq_nsw_rem_zero_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬(True ∧ x.smulOverflow (BitVec.ofInt 8 (-5)) = true) →
    ofBool (x * BitVec.ofInt 8 (-5) == 20#8) = ofBool (x == BitVec.ofInt 8 (-4)) :=
sorry