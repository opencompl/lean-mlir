
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem icmp_ne_zext_eq_zero_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (zeroExtend 32 (ofBool (x == 0#32)) != x) = 1#1 :=
sorry