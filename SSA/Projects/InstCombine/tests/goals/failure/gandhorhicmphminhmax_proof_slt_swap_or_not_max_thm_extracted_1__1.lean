
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem slt_swap_or_not_max_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  ofBool (x <ₛ x_1) ||| ofBool (x != 127#8) = ofBool (x != 127#8) :=
sorry