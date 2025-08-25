
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem icmp_ule_64_thm.extracted_1._1 : ∀ (x : BitVec 128),
  ¬(True ∧ x <<< 64#128 >>> 64#128 ≠ x ∨ 64#128 ≥ ↑128) →
    ofBool (x <<< 64#128 ≤ᵤ 18446744073709551615#128) = ofBool (x == 0#128) :=
sorry