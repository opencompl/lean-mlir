
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem ne_optimized_highbits_cmp_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ofBool (16777215#32 <ᵤ x_1 ^^^ x) ||| ofBool (truncate 24 x != truncate 24 x_1) = ofBool (x_1 != x) :=
sorry