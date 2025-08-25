
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem eq_optimized_highbits_cmp_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ofBool (x_1 ^^^ x <ᵤ 33554432#32) &&& ofBool (truncate 25 x == truncate 25 x_1) = ofBool (x_1 == x) :=
sorry