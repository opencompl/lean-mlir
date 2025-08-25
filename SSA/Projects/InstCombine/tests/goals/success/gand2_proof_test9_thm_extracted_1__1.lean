
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test9_thm.extracted_1._1 : ∀ (x : BitVec 64),
  ¬(True ∧ (0#64).ssubOverflow x = true) → 0#64 - x &&& 1#64 = x &&& 1#64 :=
sorry