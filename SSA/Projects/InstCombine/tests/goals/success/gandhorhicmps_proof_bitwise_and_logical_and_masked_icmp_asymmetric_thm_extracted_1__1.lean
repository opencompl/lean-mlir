
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem bitwise_and_logical_and_masked_icmp_asymmetric_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬ofBool (x &&& 255#32 != 0#32) = 1#1 → ofBool (x &&& 11#32 == 11#32) = 1#1 → False :=
sorry