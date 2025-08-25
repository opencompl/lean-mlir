
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem cond_eq_and_const_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  ofBool (x_1 == 10#8) = 1#1 → ofBool (x_1 <ᵤ x) = ofBool (10#8 <ᵤ x) :=
sorry