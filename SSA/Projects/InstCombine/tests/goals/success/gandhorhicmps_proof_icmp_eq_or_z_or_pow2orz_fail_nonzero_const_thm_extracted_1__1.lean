
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem icmp_eq_or_z_or_pow2orz_fail_nonzero_const_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  ofBool (x_1 == 1#8) ||| ofBool (x_1 == 0#8 - x &&& x) = ofBool (x_1 == 1#8) ||| ofBool (x_1 == x &&& 0#8 - x) :=
sorry