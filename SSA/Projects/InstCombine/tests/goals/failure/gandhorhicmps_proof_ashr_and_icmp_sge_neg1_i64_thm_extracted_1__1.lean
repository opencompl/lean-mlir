
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem ashr_and_icmp_sge_neg1_i64_thm.extracted_1._1 : ∀ (x : BitVec 64),
  ¬63#64 ≥ ↑64 → x.sshiftRight' 63#64 &&& zeroExtend 64 (ofBool (-1#64 ≤ₛ x)) = zeroExtend 64 (ofBool (x == -1#64)) :=
sorry