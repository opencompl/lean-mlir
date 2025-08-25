
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem icmp_slt_0_or_icmp_sgt_0_i32_thm.extracted_1._1 : ∀ (x : BitVec 32),
  zeroExtend 32 (ofBool (x <ₛ 0#32)) ||| zeroExtend 32 (ofBool (0#32 <ₛ x)) = zeroExtend 32 (ofBool (x != 0#32)) :=
sorry