
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem xor_of_icmps_to_ne_commute_thm.extracted_1._1 : ∀ (x : BitVec 64),
  ofBool (x <ₛ 6#64) ^^^ ofBool (4#64 <ₛ x) = ofBool (x != 5#64) :=
sorry