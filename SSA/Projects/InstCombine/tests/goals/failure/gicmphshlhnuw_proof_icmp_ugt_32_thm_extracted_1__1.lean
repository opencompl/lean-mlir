
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem icmp_ugt_32_thm.extracted_1._1 : ∀ (x : BitVec 64),
  ¬(True ∧ x <<< 32#64 >>> 32#64 ≠ x ∨ 32#64 ≥ ↑64) → ofBool (4294967295#64 <ᵤ x <<< 32#64) = ofBool (x != 0#64) :=
sorry