
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test11_thm.extracted_1._2 : ∀ (x : BitVec 8),
  ¬(True ∧ (x &&& BitVec.ofInt 8 (-13) &&& 8#8 != 0) = true) →
    (x ||| 12#8) ^^^ 4#8 = x &&& BitVec.ofInt 8 (-13) ||| 8#8 :=
sorry