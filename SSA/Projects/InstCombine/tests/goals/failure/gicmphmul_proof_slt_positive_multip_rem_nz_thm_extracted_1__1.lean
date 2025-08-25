
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem slt_positive_multip_rem_nz_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬(True ∧ x.smulOverflow 5#8 = true) → ofBool (x * 5#8 <ₛ 21#8) = ofBool (x <ₛ 5#8) :=
sorry