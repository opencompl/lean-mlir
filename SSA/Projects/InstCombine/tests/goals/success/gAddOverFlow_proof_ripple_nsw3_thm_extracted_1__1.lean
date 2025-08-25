
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem ripple_nsw3_thm.extracted_1._1 : ∀ (x x_1 : BitVec 16),
  True ∧ (x_1 &&& BitVec.ofInt 16 (-21845)).saddOverflow (x &&& 21843#16) = true ∨
      True ∧ (x_1 &&& BitVec.ofInt 16 (-21845)).uaddOverflow (x &&& 21843#16) = true →
    False :=
sorry