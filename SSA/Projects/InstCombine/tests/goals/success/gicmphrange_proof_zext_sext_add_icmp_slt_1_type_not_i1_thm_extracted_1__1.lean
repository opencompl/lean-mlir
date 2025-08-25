
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem zext_sext_add_icmp_slt_1_type_not_i1_thm.extracted_1._1 : ∀ (x : BitVec 1) (x_1 : BitVec 2),
  True ∧ (zeroExtend 8 x_1).saddOverflow (signExtend 8 x) = true → False :=
sorry