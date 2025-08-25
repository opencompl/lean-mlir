
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem cmp_x_and_negp2_with_eq_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ofBool (x &&& BitVec.ofInt 8 (-2) == BitVec.ofInt 8 (-128)) = ofBool (x <ₛ BitVec.ofInt 8 (-126)) :=
sorry