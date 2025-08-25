
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem ugt_swap_or_not_min_commute_thm.extracted_1._1 : ∀ (x x_1 : BitVec 823),
  ofBool (x_1 != 0#823) ||| ofBool (x <ᵤ x_1) = ofBool (x_1 != 0#823) :=
sorry