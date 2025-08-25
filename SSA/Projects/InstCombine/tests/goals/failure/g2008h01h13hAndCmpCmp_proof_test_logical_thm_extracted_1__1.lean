
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test_logical_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (x != 34#32) = 1#1 → ofBool (-1#32 <ₛ x) = ofBool (x != 34#32) &&& ofBool (-1#32 <ₛ x) :=
sorry