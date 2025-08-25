
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test24_logical_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (1#32 <ₛ x) = 1#1 → ofBool (x != 2#32) = ofBool (2#32 <ₛ x) :=
sorry