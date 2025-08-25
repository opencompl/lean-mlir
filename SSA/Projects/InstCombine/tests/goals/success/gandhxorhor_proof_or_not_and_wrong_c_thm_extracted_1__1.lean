
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem or_not_and_wrong_c_thm.extracted_1._1 : ∀ (x x_1 x_2 x_3 : BitVec 32),
  ((x_3 ||| x_2) ^^^ -1#32) &&& x_1 ||| ((x_3 ||| x) ^^^ -1#32) &&& x_2 =
    x_1 &&& ((x_3 ||| x_2) ^^^ -1#32) ||| x_2 &&& ((x_3 ||| x) ^^^ -1#32) :=
sorry