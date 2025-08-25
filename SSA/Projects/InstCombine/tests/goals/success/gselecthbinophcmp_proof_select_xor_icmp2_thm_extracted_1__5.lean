
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem select_xor_icmp2_thm.extracted_1._5 : ∀ (x x_1 x_2 : BitVec 32),
  ¬ofBool (x_2 != 0#32) = 1#1 → ofBool (x_2 == 0#32) = 1#1 → x_2 ^^^ x = x :=
sorry