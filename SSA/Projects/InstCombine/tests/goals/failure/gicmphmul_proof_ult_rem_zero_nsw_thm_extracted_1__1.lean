
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem ult_rem_zero_nsw_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬(True ∧ x.smulOverflow 7#8 = true ∨ True ∧ x.umulOverflow 7#8 = true) →
    ofBool (x * 7#8 <ᵤ 21#8) = ofBool (x <ᵤ 3#8) :=
sorry