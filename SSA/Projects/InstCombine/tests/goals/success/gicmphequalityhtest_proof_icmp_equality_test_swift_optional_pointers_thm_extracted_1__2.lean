
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem icmp_equality_test_swift_optional_pointers_thm.extracted_1._2 : ∀ (x x_1 : BitVec 64),
  ofBool (x_1 == 0#64) = 1#1 → ¬True → ofBool (x == 0#64) = ofBool (x_1 == x) :=
sorry