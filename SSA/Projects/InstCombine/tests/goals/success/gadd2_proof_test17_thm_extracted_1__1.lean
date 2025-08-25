
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test17_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ¬(True ∧ (x_1 &&& BitVec.ofInt 32 (-1431655766) ^^^ BitVec.ofInt 32 (-1431655765)).saddOverflow x = true) →
    (x_1 &&& BitVec.ofInt 32 (-1431655766) ^^^ BitVec.ofInt 32 (-1431655765)) + x = x - (x_1 ||| 1431655765#32) :=
sorry