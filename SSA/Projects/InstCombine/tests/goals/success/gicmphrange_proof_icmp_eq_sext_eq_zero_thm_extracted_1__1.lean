
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem icmp_eq_sext_eq_zero_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (signExtend 32 (ofBool (x == 0#32)) == x) = 0#1 :=
sorry