
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem xor_of_icmps_neg_to_ne_thm.extracted_1._1 : ∀ (x : BitVec 64),
  ofBool (BitVec.ofInt 64 (-6) <ₛ x) ^^^ ofBool (x <ₛ BitVec.ofInt 64 (-4)) = ofBool (x != BitVec.ofInt 64 (-5)) :=
sorry