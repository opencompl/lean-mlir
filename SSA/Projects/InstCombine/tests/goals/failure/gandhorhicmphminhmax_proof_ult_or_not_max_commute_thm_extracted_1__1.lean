
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem ult_or_not_max_commute_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  ofBool (x_1 != -1#8) ||| ofBool (x_1 <ᵤ x) = ofBool (x_1 != -1#8) :=
sorry