
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem mul_of_bool_commute_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ofBool (255#32 <ᵤ (x_1 &&& 255#32) * (x &&& 1#32)) = 0#1 :=
sorry