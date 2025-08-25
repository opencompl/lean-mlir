
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem select_or_icmp_bad_thm.extracted_1._2 : ∀ (x x_1 x_2 : BitVec 32),
  ofBool (x_2 == 3#32) = 1#1 → x_2 ||| x_1 = x_1 ||| 3#32 :=
sorry