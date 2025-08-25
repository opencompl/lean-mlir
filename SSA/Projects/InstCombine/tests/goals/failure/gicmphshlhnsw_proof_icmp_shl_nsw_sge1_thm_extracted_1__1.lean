
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem icmp_shl_nsw_sge1_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬(True ∧ (x <<< 21#32).sshiftRight' 21#32 ≠ x ∨ 21#32 ≥ ↑32) → ofBool (1#32 ≤ₛ x <<< 21#32) = ofBool (0#32 <ₛ x) :=
sorry