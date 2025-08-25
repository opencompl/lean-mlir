
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test18_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  (x_1 ^^^ 33#8 ^^^ x ||| x ^^^ x_1) * (x_1 ^^^ 33#8 ^^^ x) =
    (x_1 ^^^ x ^^^ 33#8 ||| x ^^^ x_1) * (x_1 ^^^ x ^^^ 33#8) :=
sorry