
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem icmp_select_var_select_thm.extracted_1._3 : ∀ (x : BitVec 8) (x_1 : BitVec 1),
  x_1 = 1#1 →
    ofBool (x == 0#8) = 1#1 ∧ x_1 = 1#1 → ¬ofBool (x == 0#8) = 1#1 → x_1 ^^^ 1#1 = 1#1 → ofBool (x == x) = 1#1 :=
sorry