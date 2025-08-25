
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem select_xor_icmp_bad_6_thm.extracted_1._6 : ∀ (x x_1 x_2 : BitVec 32),
  ¬ofBool (x_2 != 1#32) = 1#1 → ¬ofBool (x_2 == 1#32) = 1#1 → x_2 ^^^ x = x_1 :=
sorry