
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem bitwise_and_logical_and_masked_icmp_allones_poison2_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ¬ofBool (x_1 &&& 8#32 == 8#32) = 1#1 → ofBool (x_1 &&& 8#32 != 0#32) = 1#1 → False :=
sorry