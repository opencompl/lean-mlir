
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem substitute_constant_or_ne_uge_commute_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  ofBool (x ≤ᵤ x_1) ||| ofBool (x_1 != 42#8) = ofBool (x_1 != 42#8) ||| ofBool (x <ᵤ 43#8) :=
sorry