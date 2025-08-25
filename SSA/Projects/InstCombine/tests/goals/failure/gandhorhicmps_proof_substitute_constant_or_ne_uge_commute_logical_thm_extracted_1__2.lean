
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem substitute_constant_or_ne_uge_commute_logical_thm.extracted_1._2 : ∀ (x x_1 : BitVec 8),
  ¬ofBool (x ≤ᵤ x_1) = 1#1 → ofBool (x_1 != 42#8) = ofBool (x_1 != 42#8) ||| ofBool (x <ᵤ 43#8) :=
sorry