
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem zext_sext_add_icmp_i128_thm.extracted_1._1 : ∀ (x x_1 : BitVec 1),
  ofBool (9223372036854775808#128 <ₛ zeroExtend 128 x_1 + signExtend 128 x) = 0#1 :=
sorry