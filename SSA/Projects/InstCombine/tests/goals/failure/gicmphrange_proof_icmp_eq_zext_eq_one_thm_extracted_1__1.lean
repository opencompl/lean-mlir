
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem icmp_eq_zext_eq_one_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (zeroExtend 32 (ofBool (x == 1#32)) == x) = ofBool (x <ᵤ 2#32) :=
sorry