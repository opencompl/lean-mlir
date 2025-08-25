
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem ashr_icmp1_thm.extracted_1._1 : ∀ (x : BitVec 64),
  ¬(True ∧ x >>> 2#64 <<< 2#64 ≠ x ∨ 2#64 ≥ ↑64) → ofBool (x.sshiftRight' 2#64 == 0#64) = ofBool (x == 0#64) :=
sorry