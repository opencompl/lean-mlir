
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem icmp_slt_0_xor_icmp_sge_neg2_i32_fail_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬31#32 ≥ ↑32 →
    x >>> 31#32 ^^^ zeroExtend 32 (ofBool (BitVec.ofInt 32 (-2) ≤ₛ x)) =
      zeroExtend 32 (ofBool (x <ᵤ BitVec.ofInt 32 (-2))) :=
sorry