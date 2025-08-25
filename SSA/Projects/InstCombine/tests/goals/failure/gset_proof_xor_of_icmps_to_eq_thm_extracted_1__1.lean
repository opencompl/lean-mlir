
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem xor_of_icmps_to_eq_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ofBool (x <ₛ BitVec.ofInt 8 (-128)) ^^^ ofBool (126#8 <ₛ x) = ofBool (x == 127#8) :=
sorry