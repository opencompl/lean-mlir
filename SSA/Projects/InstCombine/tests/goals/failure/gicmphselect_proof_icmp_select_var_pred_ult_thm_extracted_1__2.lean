
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem icmp_select_var_pred_ult_thm.extracted_1._2 : ∀ (x x_1 x_2 : BitVec 8),
  ofBool (x_2 == 0#8) = 1#1 → ¬(True ∧ x_1.uaddOverflow 2#8 = true) → ofBool (x_1 <ᵤ x_1 + 2#8) = 1#1 :=
sorry