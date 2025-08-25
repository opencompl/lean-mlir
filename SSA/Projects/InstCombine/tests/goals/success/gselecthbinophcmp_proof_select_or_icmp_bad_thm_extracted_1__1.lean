
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem select_or_icmp_bad_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ofBool (x_1 == 3#32) = 1#1 → x_1 ||| x = x ||| 3#32 :=
sorry