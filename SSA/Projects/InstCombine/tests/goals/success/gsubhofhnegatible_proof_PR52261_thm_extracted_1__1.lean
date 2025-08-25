
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem PR52261_thm.extracted_1._1 : ∀ (x : BitVec 1),
  x = 1#1 → ¬(True ∧ (0#32).ssubOverflow 2#32 = true) → 2#32 &&& 0#32 - 2#32 = 2#32 :=
sorry