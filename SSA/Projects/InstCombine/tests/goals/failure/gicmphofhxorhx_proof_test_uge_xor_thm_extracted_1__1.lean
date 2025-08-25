
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test_uge_xor_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ofBool (x_1 ^^^ -1#32 ≤ᵤ x_1 ^^^ -1#32 ^^^ x) = ofBool (x ^^^ x_1 ≤ᵤ x_1) :=
sorry