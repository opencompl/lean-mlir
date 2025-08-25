
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem icmp_eq_mul_nuw_nonequal_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  ¬(True ∧ x_1.umulOverflow x = true ∨ True ∧ (x_1 + 1#8).umulOverflow x = true) →
    ofBool (x_1 * x == (x_1 + 1#8) * x) = ofBool (x == 0#8) :=
sorry