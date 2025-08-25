
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem not_and_and_or_not_or_or_commute2_or_thm.extracted_1._1 : ∀ (x x_1 x_2 : BitVec 32),
  (x_2 ^^^ -1#32) &&& x_1 &&& x ||| (x_1 ||| x ||| x_2) ^^^ -1#32 = (x ^^^ x_1 ||| x_2) ^^^ -1#32 :=
sorry