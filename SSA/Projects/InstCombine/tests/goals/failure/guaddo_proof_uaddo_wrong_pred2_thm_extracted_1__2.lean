
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem uaddo_wrong_pred2_thm.extracted_1._2 : ∀ (x x_1 x_2 : BitVec 32),
  ofBool (x_1 ^^^ -1#32 ≤ᵤ x_2) = 1#1 → ofBool (x_2 <ᵤ x_1 ^^^ -1#32) = 1#1 → x = x_2 + x_1 :=
sorry