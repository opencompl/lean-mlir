
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem icmp_select_var_pred_uge_commuted_thm.extracted_1._2 : ∀ (x x_1 x_2 : BitVec 8),
  ¬(True ∧ x_2.uaddOverflow 2#8 = true) → ofBool (x_1 == 0#8) = 1#1 → ofBool (x_2 ≤ᵤ x_2 + 2#8) = 1#1 :=
sorry