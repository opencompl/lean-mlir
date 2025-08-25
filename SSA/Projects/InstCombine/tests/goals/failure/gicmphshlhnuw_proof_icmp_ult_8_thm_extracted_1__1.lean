
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem icmp_ult_8_thm.extracted_1._1 : ∀ (x : BitVec 64),
  ¬(True ∧ x <<< 8#64 >>> 8#64 ≠ x ∨ 8#64 ≥ ↑64) → ofBool (x <<< 8#64 <ᵤ 4095#64) = ofBool (x <ᵤ 16#64) :=
sorry