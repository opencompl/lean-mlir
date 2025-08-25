
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem icmp_mul_nsw_slt_neg_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  ¬(True ∧ x_1.smulOverflow (BitVec.ofInt 8 (-7)) = true ∨ True ∧ x.smulOverflow (BitVec.ofInt 8 (-7)) = true) →
    ofBool (x_1 * BitVec.ofInt 8 (-7) <ₛ x * BitVec.ofInt 8 (-7)) = ofBool (x <ₛ x_1) :=
sorry