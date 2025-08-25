
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test2_thm.extracted_1._1 : ∀ (x x_1 : BitVec 39),
  x_1 + (x &&& BitVec.ofInt 39 (-274877906944)) &&& (274877906943#39 ^^^ -1#39) ||| x_1 &&& 274877906943#39 =
    x_1 + (x &&& BitVec.ofInt 39 (-274877906944)) :=
sorry