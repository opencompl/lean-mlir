
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem or_simplify_ugt_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  ofBool (x &&& BitVec.ofInt 8 (-2) <ᵤ x_1 ||| 1#8 ||| x &&& BitVec.ofInt 8 (-2)) =
    ofBool (x &&& BitVec.ofInt 8 (-2) <ᵤ x_1 ||| x ||| 1#8) :=
sorry