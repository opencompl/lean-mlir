
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem select_constants_and_icmp_ne0_zero_fval_thm.extracted_1._4 : ∀ (x x_1 : BitVec 1),
  ¬x_1 = 1#1 → ¬x = 1#1 → ofBool (0#8 &&& 0#8 != 0#8) = 0#1 :=
sorry