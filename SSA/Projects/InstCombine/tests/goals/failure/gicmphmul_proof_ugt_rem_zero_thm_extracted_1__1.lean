
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem ugt_rem_zero_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬(True ∧ x.umulOverflow 7#8 = true) → ofBool (21#8 <ᵤ x * 7#8) = ofBool (3#8 <ᵤ x) :=
sorry