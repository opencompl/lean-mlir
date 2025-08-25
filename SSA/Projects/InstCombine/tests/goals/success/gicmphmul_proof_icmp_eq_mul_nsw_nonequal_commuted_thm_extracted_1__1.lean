
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem icmp_eq_mul_nsw_nonequal_commuted_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  ¬(True ∧ x_1.smulOverflow x = true ∨ True ∧ x.smulOverflow (x_1 + 1#8) = true) →
    ofBool (x_1 * x == x * (x_1 + 1#8)) = ofBool (x == 0#8) :=
sorry