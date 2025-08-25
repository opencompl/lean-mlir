
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem icmp_select_var_pred_uge_thm.extracted_1._2 : ∀ (x x_1 : BitVec 8),
  ofBool (x_1 == 0#8) = 1#1 →
    ¬(True ∧ x.uaddOverflow 2#8 = true) → ¬ofBool (x_1 != 0#8) = 1#1 → ofBool (x + 2#8 ≤ᵤ x) = 0#1 :=
sorry