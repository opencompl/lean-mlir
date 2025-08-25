
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem or_simplify_ult_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  ofBool (x_1 &&& BitVec.ofInt 8 (-5) <ᵤ x ||| 36#8 ||| x_1 &&& BitVec.ofInt 8 (-5)) =
    ofBool (x_1 &&& BitVec.ofInt 8 (-5) <ᵤ x ||| x_1 ||| 36#8) :=
sorry