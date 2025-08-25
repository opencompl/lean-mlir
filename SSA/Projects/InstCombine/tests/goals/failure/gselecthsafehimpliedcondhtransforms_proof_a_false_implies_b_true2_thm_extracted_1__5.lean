
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem a_false_implies_b_true2_thm.extracted_1._5 : ∀ (x x_1 : BitVec 1) (x_2 : BitVec 8),
  ofBool (x_2 <ᵤ 20#8) = 1#1 → ofBool (10#8 <ᵤ x_2) = 1#1 → ofBool (10#8 <ᵤ x_2) ||| x_1 = 1#1 :=
sorry