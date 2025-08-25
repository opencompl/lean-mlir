
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem icmp_slt_0_or_icmp_sgt_0_i64_thm.extracted_1._1 : ∀ (x : BitVec 64),
  zeroExtend 64 (ofBool (x <ₛ 0#64)) ||| zeroExtend 64 (ofBool (0#64 <ₛ x)) = zeroExtend 64 (ofBool (x != 0#64)) :=
sorry