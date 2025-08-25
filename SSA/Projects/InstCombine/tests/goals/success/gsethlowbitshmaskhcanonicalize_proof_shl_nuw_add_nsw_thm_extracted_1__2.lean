
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem shl_nuw_add_nsw_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬(True ∧ 1#32 <<< x >>> x ≠ 1#32 ∨ x ≥ ↑32 ∨ True ∧ (1#32 <<< x).saddOverflow (-1#32) = true) →
    ¬(True ∧ ((-1#32) <<< x).sshiftRight' x ≠ -1#32 ∨ x ≥ ↑32) → 1#32 <<< x + -1#32 = (-1#32) <<< x ^^^ -1#32 :=
sorry