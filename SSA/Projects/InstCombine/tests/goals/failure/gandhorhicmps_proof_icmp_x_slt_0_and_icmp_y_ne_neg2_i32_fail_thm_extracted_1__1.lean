
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem icmp_x_slt_0_and_icmp_y_ne_neg2_i32_fail_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ¬31#32 ≥ ↑32 →
    x_1 >>> 31#32 &&& zeroExtend 32 (ofBool (x != BitVec.ofInt 32 (-2))) =
      zeroExtend 32 (ofBool (x_1 <ₛ 0#32) &&& ofBool (x != BitVec.ofInt 32 (-2))) :=
sorry