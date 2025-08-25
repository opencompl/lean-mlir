
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem select_constants_and_icmp_ne0_common_bit_thm.extracted_1._1 : ∀ (x x_1 : BitVec 1),
  x_1 = 1#1 → x = 1#1 → ofBool (2#8 &&& 2#8 != 0#8) = 1#1 :=
sorry