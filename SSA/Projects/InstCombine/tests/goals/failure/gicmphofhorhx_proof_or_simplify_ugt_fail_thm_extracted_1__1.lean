
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem or_simplify_ugt_fail_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  ofBool (x ||| 1#8 <ᵤ x_1 &&& BitVec.ofInt 8 (-2) ||| (x ||| 1#8)) = ofBool (x_1 ||| (x ||| 1#8) != x ||| 1#8) :=
sorry