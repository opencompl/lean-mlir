
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem zext_sext_add_icmp_slt_2_thm.extracted_1._1 : ∀ (x x_1 : BitVec 1),
  ofBool (zeroExtend 8 x_1 + signExtend 8 x <ₛ 2#8) = 1#1 :=
sorry