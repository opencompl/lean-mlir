
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem sgt_positive_multip_rem_nz_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬(True ∧ x.smulOverflow 5#8 = true) → ofBool (21#8 <ₛ x * 5#8) = ofBool (4#8 <ₛ x) :=
sorry