
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem select_icmp_eq_0_and_1_xor_1_thm.extracted_1._2 : ∀ (x : BitVec 32) (x_1 : BitVec 64),
  ¬ofBool (x_1 &&& 1#64 == 0#64) = 1#1 → x ^^^ 1#32 = x ^^^ truncate 32 x_1 &&& 1#32 :=
sorry