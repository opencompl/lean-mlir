
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem bool_eq0_thm.extracted_1._1 : ∀ (x : BitVec 64),
  ofBool (0#64 <ₛ x) &&& ofBool (ofBool (x == 1#64) == 0#1) = ofBool (1#64 <ₛ x) :=
sorry