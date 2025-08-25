
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem icmp_x_slt_0_xor_icmp_y_sgt_neg1_i32_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ¬31#32 ≥ ↑32 → x_1 >>> 31#32 ^^^ zeroExtend 32 (ofBool (-1#32 <ₛ x)) = zeroExtend 32 (ofBool (-1#32 <ₛ x_1 ^^^ x)) :=
sorry