
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem n3_constmask_samemask_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  True ∧ (x_1 &&& 65280#32).saddOverflow (x &&& 65280#32) = true ∨
      True ∧ (x_1 &&& 65280#32).uaddOverflow (x &&& 65280#32) = true →
    False :=
sorry