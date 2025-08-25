
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test33_thm.extracted_1._1 : ∀ (x : BitVec 32),
  x &&& BitVec.ofInt 32 (-2) ||| x &&& 1#32 ^^^ 1#32 = x ^^^ 1#32 :=
sorry