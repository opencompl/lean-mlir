
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem icmp_equality_test_constant_thm.extracted_1._1 : ∀ (x x_1 : BitVec 42),
  ofBool (x_1 == BitVec.ofInt 42 (-42)) = 1#1 → ofBool (x == BitVec.ofInt 42 (-42)) = ofBool (x_1 == x) :=
sorry