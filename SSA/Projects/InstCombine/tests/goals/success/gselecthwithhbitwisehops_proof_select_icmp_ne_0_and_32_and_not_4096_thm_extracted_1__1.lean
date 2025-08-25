
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem select_icmp_ne_0_and_32_and_not_4096_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ofBool (0#32 != x_1 &&& 32#32) = 1#1 → ofBool (x_1 &&& 32#32 == 0#32) = 1#1 → x = x &&& BitVec.ofInt 32 (-4097) :=
sorry