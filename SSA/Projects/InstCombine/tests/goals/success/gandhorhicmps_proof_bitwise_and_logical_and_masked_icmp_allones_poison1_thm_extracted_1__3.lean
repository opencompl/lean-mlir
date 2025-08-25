
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem bitwise_and_logical_and_masked_icmp_allones_poison1_thm.extracted_1._3 : ∀ (x : BitVec 1) (x_1 x_2 : BitVec 32),
  ofBool (x_2 &&& x_1 == x_1) = 1#1 →
    ofBool (x_2 &&& (x_1 ||| 7#32) == x_1 ||| 7#32) = 1#1 → x &&& ofBool (x_2 &&& 7#32 == 7#32) = x :=
sorry