
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem PR32830_thm.extracted_1._1 : ∀ (x x_1 x_2 : BitVec 64),
  (x_2 ^^^ -1#64 ||| x_1) &&& (x_1 ^^^ -1#64 ||| x) = (x_1 ||| x_2 ^^^ -1#64) &&& (x ||| x_1 ^^^ -1#64) :=
sorry