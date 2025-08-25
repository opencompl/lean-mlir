
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem icmp_mul_nsw_slt_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  ¬(True ∧ x_1.smulOverflow 7#8 = true ∨ True ∧ x.smulOverflow 7#8 = true) →
    ofBool (x_1 * 7#8 <ₛ x * 7#8) = ofBool (x_1 <ₛ x) :=
sorry