
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem ugt_rem_nz_nsw_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬(True ∧ x.smulOverflow 5#8 = true ∨ True ∧ x.umulOverflow 5#8 = true) →
    ofBool (21#8 <ᵤ x * 5#8) = ofBool (4#8 <ᵤ x) :=
sorry