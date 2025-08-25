
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem xor_or_thm.extracted_1._5 : ∀ (x x_1 : BitVec 32) (x_2 : BitVec 1),
  x_2 = 1#1 → x_2 ^^^ 1#1 = 1#1 → 1#1 ^^^ 1#1 = ofBool (x ≤ᵤ x_1) :=
sorry