
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem icmp_eq_or_z_or_pow2orz_fail_bad_pred2_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  ofBool (x_1 ≤ₛ 0#8) ||| ofBool (x_1 ≤ₛ 0#8 - x &&& x) = ofBool (x_1 <ₛ 1#8) ||| ofBool (x_1 ≤ₛ x &&& 0#8 - x) :=
sorry