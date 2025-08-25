
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem ripple_nsw5_thm.extracted_1._1 : ∀ (x x_1 : BitVec 16),
  True ∧ (x_1 ||| BitVec.ofInt 16 (-21845)).saddOverflow (x ||| BitVec.ofInt 16 (-10923)) = true → False :=
sorry