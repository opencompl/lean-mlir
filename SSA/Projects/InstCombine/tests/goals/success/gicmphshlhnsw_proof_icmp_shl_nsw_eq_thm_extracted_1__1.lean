
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem icmp_shl_nsw_eq_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬(True ∧ (x <<< 5#32).sshiftRight' 5#32 ≠ x ∨ 5#32 ≥ ↑32) → ofBool (x <<< 5#32 == 0#32) = ofBool (x == 0#32) :=
sorry