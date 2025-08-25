
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem slt_positive_multip_rem_zero_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬(True ∧ x.smulOverflow 7#8 = true) → ofBool (x * 7#8 <ₛ 21#8) = ofBool (x <ₛ 3#8) :=
sorry