
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem c_0_1_0_thm.extracted_1._2 : ∀ (x x_1 : BitVec 4),
  ¬(True ∧ (x &&& BitVec.ofInt 4 (-2) &&& (x_1 &&& 1#4) != 0) = true) →
    (x_1 ^^^ x) &&& BitVec.ofInt 4 (-2) ^^^ x_1 = x &&& BitVec.ofInt 4 (-2) ||| x_1 &&& 1#4 :=
sorry