
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem icmp_slt_0_or_icmp_add_1_sge_100_i32_fail_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬31#32 ≥ ↑32 →
    x >>> 31#32 ||| zeroExtend 32 (ofBool (100#32 ≤ₛ x + 1#32)) =
      zeroExtend 32 (ofBool (x <ₛ 0#32) ||| ofBool (99#32 <ₛ x + 1#32)) :=
sorry