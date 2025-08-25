
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem logical_and_implies_folds_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (42#32 <ᵤ x) = 1#1 → ofBool (x != 0#32) = ofBool (42#32 <ᵤ x) :=
sorry