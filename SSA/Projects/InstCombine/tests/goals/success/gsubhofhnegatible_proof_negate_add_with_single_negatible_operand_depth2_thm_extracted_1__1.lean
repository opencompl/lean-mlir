
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem negate_add_with_single_negatible_operand_depth2_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  0#8 - (x_1 + 21#8) * x = (BitVec.ofInt 8 (-21) - x_1) * x :=
sorry