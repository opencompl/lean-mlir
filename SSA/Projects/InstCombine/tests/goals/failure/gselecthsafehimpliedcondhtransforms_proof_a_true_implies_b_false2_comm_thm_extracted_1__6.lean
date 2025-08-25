
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem a_true_implies_b_false2_comm_thm.extracted_1._6 : ∀ (x x_1 : BitVec 1) (x_2 : BitVec 8),
  ofBool (x_2 == 10#8) = 1#1 → ¬ofBool (20#8 <ᵤ x_2) = 1#1 → x_1 &&& ofBool (20#8 <ᵤ x_2) = 0#1 :=
sorry