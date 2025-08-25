
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem shl_nsw_add_negative_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬(True ∧ (2#32 <<< (x + -1#32)).sshiftRight' (x + -1#32) ≠ 2#32 ∨ x + -1#32 ≥ ↑32) →
    ¬(True ∧ 1#32 <<< x >>> x ≠ 1#32 ∨ x ≥ ↑32) → 2#32 <<< (x + -1#32) = 1#32 <<< x :=
sorry