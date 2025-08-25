
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem or_and_not_not_commute7_thm.extracted_1._1 : ∀ (x x_1 x_2 : BitVec 32),
  ((x_2 ||| x_1) ^^^ -1#32) &&& x ||| (x_1 ||| x) ^^^ -1#32 = (x_2 &&& x ||| x_1) ^^^ -1#32 :=
sorry