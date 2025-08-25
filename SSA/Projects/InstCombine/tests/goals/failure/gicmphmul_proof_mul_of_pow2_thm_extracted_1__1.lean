
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem mul_of_pow2_thm.extracted_1._1 : ∀ (x : BitVec 8) (x_1 : BitVec 32),
  ofBool (510#32 <ᵤ (x_1 &&& 2#32) * zeroExtend 32 x) = 0#1 :=
sorry