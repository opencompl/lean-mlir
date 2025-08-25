
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem ripple_nsw1_thm.extracted_1._1 : ∀ (x x_1 : BitVec 16),
  True ∧ (x_1 &&& 1#16).saddOverflow (x &&& BitVec.ofInt 16 (-16385)) = true ∨
      True ∧ (x_1 &&& 1#16).uaddOverflow (x &&& BitVec.ofInt 16 (-16385)) = true →
    False :=
sorry