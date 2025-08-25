
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem bitwise_and_logical_and_masked_icmp_allones_poison2_thm.extracted_1._3 : ∀ (x : BitVec 32) (x_1 : BitVec 1)
  (x_2 : BitVec 32),
  ¬ofBool (x_2 &&& 8#32 == 8#32) = 1#1 →
    ofBool (x_2 &&& 8#32 != 0#32) = 1#1 → 0#1 &&& ofBool (x_2 &&& x == x) = x_1 &&& ofBool (x_2 &&& x == x) :=
sorry