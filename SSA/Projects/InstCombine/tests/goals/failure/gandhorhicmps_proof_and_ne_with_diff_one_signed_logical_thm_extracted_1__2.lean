
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem and_ne_with_diff_one_signed_logical_thm.extracted_1._2 : ∀ (x : BitVec 64),
  ¬ofBool (x != -1#64) = 1#1 → 0#1 = ofBool (x + -1#64 <ᵤ BitVec.ofInt 64 (-2)) :=
sorry