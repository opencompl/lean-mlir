
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem icmp_slt_0_and_icmp_ne_neg2_i32_fail_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬31#32 ≥ ↑32 →
    x >>> 31#32 &&& zeroExtend 32 (ofBool (x != BitVec.ofInt 32 (-2))) =
      zeroExtend 32 (ofBool (x <ₛ 0#32) &&& ofBool (x != BitVec.ofInt 32 (-2))) :=
sorry