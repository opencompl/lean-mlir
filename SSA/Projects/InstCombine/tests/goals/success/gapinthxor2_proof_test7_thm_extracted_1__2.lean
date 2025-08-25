
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test7_thm.extracted_1._2 : ∀ (x : BitVec 1023),
  ¬(True ∧ (x &&& BitVec.ofInt 1023 (-70368744177664) &&& 70368040490200#1023 != 0) = true) →
    (x ||| 70368744177663#1023) ^^^ 703687463#1023 =
      x &&& BitVec.ofInt 1023 (-70368744177664) ||| 70368040490200#1023 :=
sorry