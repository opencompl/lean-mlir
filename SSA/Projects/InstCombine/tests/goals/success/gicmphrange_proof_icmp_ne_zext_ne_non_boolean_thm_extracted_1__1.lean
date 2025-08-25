
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem icmp_ne_zext_ne_non_boolean_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (zeroExtend 32 (ofBool (x != 2#32)) != x) = ofBool (x != 1#32) :=
sorry