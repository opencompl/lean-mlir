
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem a_false_implies_b_true2_comm_thm.extracted_1._3 : ∀ (x : BitVec 1) (x_1 : BitVec 8),
  ¬ofBool (x_1 <ᵤ 20#8) = 1#1 → ofBool (10#8 <ᵤ x_1) = 1#1 → x ||| ofBool (10#8 <ᵤ x_1) = 1#1 :=
sorry