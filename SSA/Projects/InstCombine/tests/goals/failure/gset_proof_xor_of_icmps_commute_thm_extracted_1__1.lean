
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem xor_of_icmps_commute_thm.extracted_1._1 : ∀ (x : BitVec 64),
  ofBool (0#64 <ₛ x) ^^^ ofBool (x == 1#64) = ofBool (1#64 <ₛ x) :=
sorry