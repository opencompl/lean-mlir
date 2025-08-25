
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem not_or_or_and_no_and_commute1_or_thm.extracted_1._1 : ∀ (x x_1 x_2 : BitVec 32),
  (x_2 ||| x_1 ||| x ^^^ -1#32) &&& (x_1 &&& x ^^^ -1#32) = x_2 &&& (x_1 ^^^ -1#32) ||| x ^^^ -1#32 :=
sorry