
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem icmp_slt_0_and_icmp_sge_neg2_i64_thm.extracted_1._1 : ∀ (x : BitVec 64),
  ¬63#64 ≥ ↑64 →
    x >>> 63#64 &&& zeroExtend 64 (ofBool (BitVec.ofInt 64 (-2) ≤ₛ x)) =
      zeroExtend 64 (ofBool (BitVec.ofInt 64 (-3) <ᵤ x)) :=
sorry