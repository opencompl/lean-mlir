
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem substitute_constant_or_ne_swap_sle_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  ofBool (x_1 != 42#8) ||| ofBool (x ≤ₛ x_1) = ofBool (x_1 != 42#8) ||| ofBool (x <ₛ 43#8) :=
sorry