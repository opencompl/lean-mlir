
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test7_thm.extracted_1._2 : ∀ (x : BitVec 47),
  ¬(True ∧ (x &&& BitVec.ofInt 47 (-70368744177664) &&& 70368040490200#47 != 0) = true) →
    (x ||| 70368744177663#47) ^^^ 703687463#47 = x &&& BitVec.ofInt 47 (-70368744177664) ||| 70368040490200#47 :=
sorry