
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem ripple_nsw2_thm.extracted_1._1 : ∀ (x x_1 : BitVec 16),
  True ∧ (x_1 &&& BitVec.ofInt 16 (-16385)).saddOverflow (x &&& 1#16) = true ∨
      True ∧ (x_1 &&& BitVec.ofInt 16 (-16385)).uaddOverflow (x &&& 1#16) = true →
    False :=
sorry