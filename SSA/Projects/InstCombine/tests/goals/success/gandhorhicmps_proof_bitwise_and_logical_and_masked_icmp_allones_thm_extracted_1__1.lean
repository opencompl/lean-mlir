
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem bitwise_and_logical_and_masked_icmp_allones_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬ofBool (x &&& 8#32 == 8#32) = 1#1 → ofBool (x &&& 15#32 == 15#32) = 1#1 → False :=
sorry