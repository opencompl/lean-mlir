
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem bitwise_and_logical_and_masked_icmp_allzeros_poison1_thm.extracted_1._4 : ∀ (x : BitVec 1)
  (x_1 x_2 : BitVec 32),
  ofBool (x_2 &&& x_1 == 0#32) = 1#1 →
    ¬ofBool (x_2 &&& (x_1 ||| 7#32) == 0#32) = 1#1 → x &&& ofBool (x_2 &&& 7#32 == 0#32) = 0#1 :=
sorry