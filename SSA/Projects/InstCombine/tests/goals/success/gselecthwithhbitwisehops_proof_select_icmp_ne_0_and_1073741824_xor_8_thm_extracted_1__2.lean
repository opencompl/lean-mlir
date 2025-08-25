
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem select_icmp_ne_0_and_1073741824_xor_8_thm.extracted_1._2 : ∀ (x : BitVec 8) (x_1 : BitVec 32),
  ¬ofBool (0#32 != x_1 &&& 1073741824#32) = 1#1 → ¬ofBool (x_1 &&& 1073741824#32 == 0#32) = 1#1 → x ^^^ 8#8 = x :=
sorry