
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem icmp_select_implied_cond_ne_thm.extracted_1._2 : ∀ (x : BitVec 8),
  ofBool (x == 0#8) = 1#1 → ¬ofBool (x != 0#8) = 1#1 → ofBool (0#8 != x) = 0#1 :=
sorry