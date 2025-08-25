
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem arbitrary_mask_sub_i8_thm.extracted_1._1 : ∀ (x : BitVec 8),
  True ∧ (11#8).ssubOverflow (x &&& 10#8) = true ∨ True ∧ (11#8).usubOverflow (x &&& 10#8) = true → False :=
sorry