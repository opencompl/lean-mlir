
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem mul_of_bool_thm.extracted_1._1 : ∀ (x : BitVec 8) (x_1 : BitVec 32),
  ofBool (255#32 <ᵤ (x_1 &&& 1#32) * zeroExtend 32 x) = 0#1 :=
sorry