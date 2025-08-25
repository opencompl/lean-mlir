
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem uadd_sat_via_add_nonstrict_thm.extracted_1._2 : ∀ (x x_1 : BitVec 32),
  ¬ofBool (x_1 + x ≤ᵤ x) = 1#1 → ¬ofBool (x <ᵤ x_1 + x) = 1#1 → x_1 + x = -1#32 :=
sorry