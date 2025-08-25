
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem icmp_select_var_both_fold_thm.extracted_1._2 : ∀ (x x_1 : BitVec 8),
  ¬ofBool (x_1 == 0#8) = 1#1 → ofBool (2#8 == x ||| 1#8) = ofBool (x_1 == 0#8) :=
sorry