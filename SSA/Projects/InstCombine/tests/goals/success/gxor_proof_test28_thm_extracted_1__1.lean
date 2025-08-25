
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test28_thm.extracted_1._1 : ∀ (x : BitVec 32),
  x + BitVec.ofInt 32 (-2147483647) ^^^ BitVec.ofInt 32 (-2147483648) = x + 1#32 :=
sorry