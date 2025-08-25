
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem n2_badmask_thm.extracted_1._1 : ∀ (x x_1 x_2 x_3 : BitVec 32),
  (x_3 ^^^ -1#32 ||| x_2) &&& (x_1 ||| x) = (x_2 ||| x_3 ^^^ -1#32) &&& (x_1 ||| x) :=
sorry