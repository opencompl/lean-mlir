
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem shl_add_nsw_nuw_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬(x ≥ ↑32 ∨ True ∧ (1#32 <<< x).saddOverflow (-1#32) = true ∨ True ∧ (1#32 <<< x).uaddOverflow (-1#32) = true) →
    1#32 <<< x + -1#32 = -1#32 :=
sorry