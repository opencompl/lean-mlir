
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem sgt_and_min_thm.extracted_1._1 : ∀ (x x_1 : BitVec 9),
  ofBool (x <ₛ x_1) &&& ofBool (x_1 == BitVec.ofInt 9 (-256)) = 0#1 :=
sorry