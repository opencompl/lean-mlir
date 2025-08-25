
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test13_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  x_1 + 1#32 + ((x ||| BitVec.ofInt 32 (-1431655767)) ^^^ 1431655766#32) = x_1 - (x &&& 1431655766#32) :=
sorry