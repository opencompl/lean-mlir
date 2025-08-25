
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem uadd_sat_via_add_swapped_cmp_nonstrict_thm.extracted_1._2 : ∀ (x x_1 : BitVec 32),
  ¬ofBool (x + x_1 ≤ᵤ x_1) = 1#1 → ¬ofBool (x_1 <ᵤ x + x_1) = 1#1 → x + x_1 = -1#32 :=
sorry