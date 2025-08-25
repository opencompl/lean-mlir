
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem ashr_icmp2_thm.extracted_1._1 : ∀ (x : BitVec 64),
  ¬(True ∧ x >>> 2#64 <<< 2#64 ≠ x ∨ 2#64 ≥ ↑64) → ofBool (x.sshiftRight' 2#64 <ₛ 4#64) = ofBool (x <ₛ 16#64) :=
sorry