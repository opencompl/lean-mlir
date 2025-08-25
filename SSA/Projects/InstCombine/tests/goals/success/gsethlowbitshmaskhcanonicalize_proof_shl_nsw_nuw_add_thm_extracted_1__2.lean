
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem shl_nsw_nuw_add_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬(True ∧ (1#32 <<< x).sshiftRight' x ≠ 1#32 ∨ True ∧ 1#32 <<< x >>> x ≠ 1#32 ∨ x ≥ ↑32) →
    ¬(True ∧ ((-1#32) <<< x).sshiftRight' x ≠ -1#32 ∨ x ≥ ↑32) → 1#32 <<< x + -1#32 = (-1#32) <<< x ^^^ -1#32 :=
sorry