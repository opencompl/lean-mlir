
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem icmp_ugt_16_thm.extracted_1._1 : ∀ (x : BitVec 64),
  ¬(True ∧ x <<< 16#64 >>> 16#64 ≠ x ∨ 16#64 ≥ ↑64) → ofBool (1048575#64 <ᵤ x <<< 16#64) = ofBool (15#64 <ᵤ x) :=
sorry