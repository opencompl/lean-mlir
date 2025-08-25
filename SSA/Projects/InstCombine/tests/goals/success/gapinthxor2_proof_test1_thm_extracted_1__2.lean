
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test1_thm.extracted_1._2 : ∀ (x x_1 : BitVec 447),
  ¬(True ∧ (x_1 &&& 70368744177664#447 &&& (x &&& 70368744177663#447) != 0) = true) →
    x_1 &&& 70368744177664#447 ^^^ x &&& 70368744177663#447 = x_1 &&& 70368744177664#447 ||| x &&& 70368744177663#447 :=
sorry