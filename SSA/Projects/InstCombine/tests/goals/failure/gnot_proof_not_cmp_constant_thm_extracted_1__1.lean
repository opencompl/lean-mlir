
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem not_cmp_constant_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (42#32 <ᵤ x ^^^ -1#32) = ofBool (x <ᵤ BitVec.ofInt 32 (-43)) :=
sorry