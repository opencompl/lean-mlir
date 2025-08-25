
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem uadd_sat_canon_nuw_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ¬(True ∧ x_1.uaddOverflow x = true) → ofBool (x_1 + x <ᵤ x_1) = 1#1 → -1#32 = x_1 + x :=
sorry