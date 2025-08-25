
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem zext_sext_add_icmp_ugt_1_thm.extracted_1._1 : ∀ (x x_1 : BitVec 1),
  ofBool (1#8 <ᵤ zeroExtend 8 x_1 + signExtend 8 x) = x &&& (x_1 ^^^ 1#1) :=
sorry