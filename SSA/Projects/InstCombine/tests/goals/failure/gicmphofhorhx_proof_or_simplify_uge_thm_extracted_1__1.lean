
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem or_simplify_uge_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  ofBool (x ||| BitVec.ofInt 8 (-127) ||| x_1 &&& 127#8 ≤ᵤ x_1 &&& 127#8) = 0#1 :=
sorry