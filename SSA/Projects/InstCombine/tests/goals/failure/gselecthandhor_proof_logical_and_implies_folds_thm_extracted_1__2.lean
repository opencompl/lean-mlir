
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem logical_and_implies_folds_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬ofBool (42#32 <ᵤ x) = 1#1 → 0#1 = ofBool (42#32 <ᵤ x) :=
sorry