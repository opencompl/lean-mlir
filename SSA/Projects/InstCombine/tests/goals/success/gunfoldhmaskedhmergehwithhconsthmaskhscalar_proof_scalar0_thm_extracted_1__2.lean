
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem scalar0_thm.extracted_1._2 : ∀ (x x_1 : BitVec 4),
  ¬(True ∧ (x_1 &&& 1#4 &&& (x &&& BitVec.ofInt 4 (-2)) != 0) = true) →
    (x_1 ^^^ x) &&& 1#4 ^^^ x = x_1 &&& 1#4 ||| x &&& BitVec.ofInt 4 (-2) :=
sorry