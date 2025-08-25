
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem select_xor_icmp_bad_6_thm.extracted_1._2 : ∀ (x x_1 : BitVec 32),
  ¬ofBool (x_1 != 1#32) = 1#1 → ofBool (x_1 == 1#32) = 1#1 → x_1 ^^^ x = x ^^^ 1#32 :=
sorry