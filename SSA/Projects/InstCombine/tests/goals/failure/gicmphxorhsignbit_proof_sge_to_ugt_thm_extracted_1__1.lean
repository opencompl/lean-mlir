
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem sge_to_ugt_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ofBool (15#8 ≤ₛ x ^^^ BitVec.ofInt 8 (-128)) = ofBool (BitVec.ofInt 8 (-114) <ᵤ x) :=
sorry