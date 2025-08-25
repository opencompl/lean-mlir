
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem slt_negative_multip_rem_zero_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬(True ∧ x.smulOverflow (BitVec.ofInt 8 (-7)) = true) →
    ofBool (x * BitVec.ofInt 8 (-7) <ₛ 21#8) = ofBool (BitVec.ofInt 8 (-3) <ₛ x) :=
sorry