
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem sgt_negative_multip_rem_zero_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬(True ∧ x.smulOverflow (BitVec.ofInt 8 (-7)) = true) →
    ofBool (21#8 <ₛ x * BitVec.ofInt 8 (-7)) = ofBool (x <ₛ BitVec.ofInt 8 (-3)) :=
sorry