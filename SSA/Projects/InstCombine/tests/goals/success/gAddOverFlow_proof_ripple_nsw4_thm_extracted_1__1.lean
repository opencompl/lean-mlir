
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem ripple_nsw4_thm.extracted_1._1 : ∀ (x x_1 : BitVec 16),
  True ∧ (x_1 &&& 21843#16).saddOverflow (x &&& BitVec.ofInt 16 (-21845)) = true ∨
      True ∧ (x_1 &&& 21843#16).uaddOverflow (x &&& BitVec.ofInt 16 (-21845)) = true →
    False :=
sorry