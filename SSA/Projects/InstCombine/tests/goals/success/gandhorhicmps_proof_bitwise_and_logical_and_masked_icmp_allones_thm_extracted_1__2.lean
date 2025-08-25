
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem bitwise_and_logical_and_masked_icmp_allones_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬ofBool (x &&& 8#32 == 8#32) = 1#1 →
    ¬ofBool (x &&& 15#32 == 15#32) = 1#1 → 0#1 &&& ofBool (x &&& 7#32 == 7#32) = 0#1 :=
sorry