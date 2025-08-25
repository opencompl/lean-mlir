
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem select_icmp_ne_0_and_8_and_not_1073741824_thm.extracted_1._2 : ∀ (x : BitVec 32) (x_1 : BitVec 8),
  ¬ofBool (0#8 != x_1 &&& 8#8) = 1#1 → ¬ofBool (x_1 &&& 8#8 == 0#8) = 1#1 → x &&& BitVec.ofInt 32 (-1073741825) = x :=
sorry