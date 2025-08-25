
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem zext_sext_add_icmp_sgt_0_thm.extracted_1._1 : ∀ (x x_1 : BitVec 1),
  ofBool (0#8 <ₛ zeroExtend 8 x_1 + signExtend 8 x) = x_1 &&& (x ^^^ 1#1) :=
sorry