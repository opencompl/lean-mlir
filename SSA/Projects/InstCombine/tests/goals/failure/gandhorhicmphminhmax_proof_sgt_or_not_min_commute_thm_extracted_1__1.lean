
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem sgt_or_not_min_commute_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  ofBool (x_1 != BitVec.ofInt 8 (-128)) ||| ofBool (x <ₛ x_1) = ofBool (x_1 != BitVec.ofInt 8 (-128)) :=
sorry