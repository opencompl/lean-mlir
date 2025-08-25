
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem icmp_slt_0_or_icmp_sgt_0_i64_fail3_thm.extracted_1._2 : ∀ (x : BitVec 64),
  ¬62#64 ≥ ↑64 →
    ¬(62#64 ≥ ↑64 ∨ 63#64 ≥ ↑64) →
      x.sshiftRight' 62#64 ||| zeroExtend 64 (ofBool (x <ₛ 0#64)) = x.sshiftRight' 62#64 ||| x >>> 63#64 :=
sorry