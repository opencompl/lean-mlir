
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem sle_swap_or_min_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  ofBool (x ≤ₛ x_1) ||| ofBool (x == BitVec.ofInt 8 (-128)) = ofBool (x ≤ₛ x_1) :=
sorry