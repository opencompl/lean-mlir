
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem xor_of_icmps_thm.extracted_1._1 : ∀ (x : BitVec 64),
  ofBool (x == 1#64) ^^^ ofBool (0#64 <ₛ x) = ofBool (1#64 <ₛ x) :=
sorry