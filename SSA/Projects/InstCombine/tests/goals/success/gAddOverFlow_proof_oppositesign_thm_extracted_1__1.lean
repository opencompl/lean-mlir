
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem oppositesign_thm.extracted_1._1 : ∀ (x x_1 : BitVec 16),
  True ∧ (x_1 ||| BitVec.ofInt 16 (-32768)).saddOverflow (x &&& 32767#16) = true → False :=
sorry