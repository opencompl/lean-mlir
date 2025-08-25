
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test3_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ofBool (BitVec.ofInt 8 (-127) ≤ₛ x) = ofBool (x != BitVec.ofInt 8 (-128)) :=
sorry