
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem or_simplify_ule_fail_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  ofBool (x_1 ||| 64#8 ||| x &&& 127#8 ≤ᵤ x &&& 127#8) = ofBool (x_1 ||| x &&& 127#8 ||| 64#8 ≤ᵤ x &&& 127#8) :=
sorry