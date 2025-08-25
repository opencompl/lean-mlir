
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem and_ne_with_diff_one_signed_thm.extracted_1._1 : ∀ (x : BitVec 64),
  ofBool (x != -1#64) &&& ofBool (x != 0#64) = ofBool (x + -1#64 <ᵤ BitVec.ofInt 64 (-2)) :=
sorry