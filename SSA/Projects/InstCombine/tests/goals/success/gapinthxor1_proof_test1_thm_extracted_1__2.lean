
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test1_thm.extracted_1._2 : ∀ (x x_1 : BitVec 47),
  ¬(True ∧ (x_1 &&& BitVec.ofInt 47 (-70368744177664) &&& (x &&& 70368744177661#47) != 0) = true) →
    x_1 &&& BitVec.ofInt 47 (-70368744177664) ^^^ x &&& 70368744177661#47 =
      x_1 &&& BitVec.ofInt 47 (-70368744177664) ||| x &&& 70368744177661#47 :=
sorry