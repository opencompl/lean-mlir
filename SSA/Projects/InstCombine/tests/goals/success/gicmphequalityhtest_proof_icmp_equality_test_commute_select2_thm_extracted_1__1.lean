
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem icmp_equality_test_commute_select2_thm.extracted_1._1 : ∀ (x x_1 x_2 : BitVec 64),
  ofBool (x_2 == x_1) ^^^ 1#1 = 1#1 → ofBool (x == x_1) = 1#1 → 0#1 = ofBool (x_2 == x) :=
sorry