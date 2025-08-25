
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem ugt_or_not_min_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  ofBool (x <ᵤ x_1) ||| ofBool (x_1 != 0#8) = ofBool (x_1 != 0#8) :=
sorry