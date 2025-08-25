
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem and_ne_with_diff_one_logical_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (x != 40#32) = 1#1 → ofBool (x != 39#32) = ofBool (x + BitVec.ofInt 32 (-41) <ᵤ BitVec.ofInt 32 (-2)) :=
sorry