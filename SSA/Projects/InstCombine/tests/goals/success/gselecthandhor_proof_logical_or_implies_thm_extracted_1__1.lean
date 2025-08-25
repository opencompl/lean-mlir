
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem logical_or_implies_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (x == 0#32) = 1#1 → 1#1 = ofBool (x == 0#32) ||| ofBool (x == 42#32) :=
sorry