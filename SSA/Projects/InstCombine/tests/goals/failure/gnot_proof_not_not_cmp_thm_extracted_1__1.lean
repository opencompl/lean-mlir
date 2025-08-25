
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem not_not_cmp_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ofBool (x_1 ^^^ -1#32 <ₛ x ^^^ -1#32) = ofBool (x <ₛ x_1) :=
sorry