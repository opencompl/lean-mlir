
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem bitwise_and_logical_and_masked_icmp_allones_poison1_thm.extracted_1._2 : ∀ (x x_1 : BitVec 32),
  ¬ofBool (x_1 &&& x == x) = 1#1 →
    ¬ofBool (x_1 &&& (x ||| 7#32) == x ||| 7#32) = 1#1 → 0#1 &&& ofBool (x_1 &&& 7#32 == 7#32) = 0#1 :=
sorry