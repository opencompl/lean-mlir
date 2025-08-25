
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem a_true_implies_b_false_thm.extracted_1._2 : ∀ (x x_1 : BitVec 1) (x_2 : BitVec 8),
  ofBool (20#8 <ᵤ x_2) = 1#1 → ofBool (x_2 <ᵤ 10#8) = 1#1 → x_1 = x :=
sorry