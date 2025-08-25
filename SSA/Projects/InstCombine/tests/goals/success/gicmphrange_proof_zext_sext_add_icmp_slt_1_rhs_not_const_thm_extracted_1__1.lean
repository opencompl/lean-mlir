
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem zext_sext_add_icmp_slt_1_rhs_not_const_thm.extracted_1._1 : ∀ (x : BitVec 8) (x_1 x_2 : BitVec 1),
  True ∧ (zeroExtend 8 x_2).saddOverflow (signExtend 8 x_1) = true → False :=
sorry