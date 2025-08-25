
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem icmp_select_implied_cond_swapped_select_thm.extracted_1._2 : ∀ (x x_1 : BitVec 8),
  ofBool (x_1 == 0#8) = 1#1 → ofBool (x == x_1) = ofBool (x == 0#8) :=
sorry