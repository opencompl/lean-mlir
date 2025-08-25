
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem bitwise_and_logical_and_masked_icmp_asymmetric_thm.extracted_1._5 : ∀ (x : BitVec 1) (x_1 : BitVec 32),
  ¬ofBool (x_1 &&& 255#32 != 0#32) = 1#1 →
    ofBool (x_1 &&& 11#32 == 11#32) = 1#1 → 0#1 &&& ofBool (x_1 &&& 11#32 == 11#32) = x :=
sorry