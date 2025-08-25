
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem shl_add_nuw_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬(True ∧ x.uaddOverflow 5#32 = true ∨ x + 5#32 ≥ ↑32) → ¬x ≥ ↑32 → 6#32 <<< (x + 5#32) = 192#32 <<< x :=
sorry