
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test7_thm.extracted_1._2 : ∀ (x x_1 : BitVec 32),
  ¬(True ∧ (x_1 &&& 7#32 &&& (x &&& 128#32) != 0) = true) →
    x_1 &&& 7#32 ^^^ x &&& 128#32 = x_1 &&& 7#32 ||| x &&& 128#32 :=
sorry