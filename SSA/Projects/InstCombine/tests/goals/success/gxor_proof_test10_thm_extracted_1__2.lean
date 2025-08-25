
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test10_thm.extracted_1._2 : ∀ (x : BitVec 8),
  ¬(True ∧ (x &&& 3#8 &&& 4#8 != 0) = true) → x &&& 3#8 ^^^ 4#8 = x &&& 3#8 ||| 4#8 :=
sorry