
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem icmp_select_var_select_thm.extracted_1._8 : ∀ (x x_1 : BitVec 8) (x_2 : BitVec 1),
  x_2 = 1#1 →
    ofBool (x_1 == 0#8) = 1#1 ∧ x_2 = 1#1 →
      ¬ofBool (x_1 == 0#8) = 1#1 → ¬x_2 ^^^ 1#1 = 1#1 → ofBool (x_1 == x_1) = ofBool (x_1 == x) :=
sorry