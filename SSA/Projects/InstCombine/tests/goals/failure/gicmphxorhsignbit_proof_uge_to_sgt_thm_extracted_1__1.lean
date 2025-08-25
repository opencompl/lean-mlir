
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem uge_to_sgt_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ofBool (15#8 ≤ᵤ x ^^^ BitVec.ofInt 8 (-128)) = ofBool (BitVec.ofInt 8 (-114) <ₛ x) :=
sorry