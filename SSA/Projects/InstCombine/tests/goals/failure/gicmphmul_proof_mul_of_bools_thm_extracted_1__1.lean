
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem mul_of_bools_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32), ofBool ((x_1 &&& 1#32) * (x &&& 1#32) <ᵤ 2#32) = 1#1 :=
sorry