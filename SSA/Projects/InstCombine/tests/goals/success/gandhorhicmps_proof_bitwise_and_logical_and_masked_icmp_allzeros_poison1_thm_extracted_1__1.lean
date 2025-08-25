
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem bitwise_and_logical_and_masked_icmp_allzeros_poison1_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ¬ofBool (x_1 &&& x == 0#32) = 1#1 → ofBool (x_1 &&& (x ||| 7#32) == 0#32) = 1#1 → False :=
sorry