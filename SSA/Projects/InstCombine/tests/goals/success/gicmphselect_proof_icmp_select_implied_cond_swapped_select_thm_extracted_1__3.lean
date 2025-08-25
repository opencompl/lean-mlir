
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem icmp_select_implied_cond_swapped_select_thm.extracted_1._3 : ∀ (x x_1 : BitVec 8),
  ¬ofBool (x_1 == 0#8) = 1#1 → ofBool (0#8 == x_1) = 0#1 :=
sorry