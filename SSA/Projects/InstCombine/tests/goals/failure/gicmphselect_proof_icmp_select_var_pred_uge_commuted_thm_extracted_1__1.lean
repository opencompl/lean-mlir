
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem icmp_select_var_pred_uge_commuted_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  ¬(True ∧ x_1.uaddOverflow 2#8 = true) → ofBool (x == 0#8) = 1#1 → ofBool (x_1 ≤ᵤ x_1 + 2#8) = 1#1 :=
sorry