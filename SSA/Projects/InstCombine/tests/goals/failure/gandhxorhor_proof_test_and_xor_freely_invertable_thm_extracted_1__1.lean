
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test_and_xor_freely_invertable_thm.extracted_1._1 : ∀ (x : BitVec 1) (x_1 x_2 : BitVec 32),
  (ofBool (x_1 <ₛ x_2) ^^^ x) &&& x = ofBool (x_2 ≤ₛ x_1) &&& x :=
sorry