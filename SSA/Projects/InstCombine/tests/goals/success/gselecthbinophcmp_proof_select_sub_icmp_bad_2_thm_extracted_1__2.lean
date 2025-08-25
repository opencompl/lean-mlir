
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem select_sub_icmp_bad_2_thm.extracted_1._2 : ∀ (x x_1 x_2 : BitVec 32),
  ofBool (x_2 == 1#32) = 1#1 → x_1 - x_2 = x_1 + -1#32 :=
sorry