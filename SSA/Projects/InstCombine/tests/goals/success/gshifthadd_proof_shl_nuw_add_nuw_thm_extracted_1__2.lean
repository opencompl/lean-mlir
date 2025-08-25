
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem shl_nuw_add_nuw_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬(True ∧ x.uaddOverflow 1#32 = true ∨ True ∧ 1#32 <<< (x + 1#32) >>> (x + 1#32) ≠ 1#32 ∨ x + 1#32 ≥ ↑32) →
    ¬(True ∧ 2#32 <<< x >>> x ≠ 2#32 ∨ x ≥ ↑32) → 1#32 <<< (x + 1#32) = 2#32 <<< x :=
sorry