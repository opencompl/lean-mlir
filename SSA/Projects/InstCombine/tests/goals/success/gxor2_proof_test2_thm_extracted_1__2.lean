
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test2_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬(True ∧ (x &&& 32#32 &&& 8#32 != 0) = true) → (x &&& 32#32) + 145#32 ^^^ 153#32 = x &&& 32#32 ||| 8#32 :=
sorry