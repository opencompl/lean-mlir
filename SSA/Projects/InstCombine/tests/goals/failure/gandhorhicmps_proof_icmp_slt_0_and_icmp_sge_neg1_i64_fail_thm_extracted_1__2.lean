
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem icmp_slt_0_and_icmp_sge_neg1_i64_fail_thm.extracted_1._2 : ∀ (x : BitVec 64),
  ¬62#64 ≥ ↑64 →
    ¬ofBool (BitVec.ofInt 64 (-2) <ₛ x) = 1#1 → x >>> 62#64 &&& zeroExtend 64 (ofBool (-1#64 ≤ₛ x)) = 0#64 :=
sorry