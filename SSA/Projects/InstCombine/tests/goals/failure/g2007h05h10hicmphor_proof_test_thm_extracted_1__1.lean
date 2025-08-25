
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (255#32 <ᵤ x) ||| ofBool (255#32 <ₛ x) = ofBool (255#32 <ᵤ x) :=
sorry