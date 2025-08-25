
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test_logical_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬ofBool (255#32 <ᵤ x) = 1#1 → ofBool (255#32 <ₛ x) = ofBool (255#32 <ᵤ x) :=
sorry