
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem select_sub_icmp_bad_2_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ofBool (x_1 == 1#32) = 1#1 → x - x_1 = x + -1#32 :=
sorry