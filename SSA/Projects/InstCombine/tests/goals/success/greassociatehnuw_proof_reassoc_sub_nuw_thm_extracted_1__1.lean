
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem reassoc_sub_nuw_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬(True ∧ x.usubOverflow 4#32 = true ∨ True ∧ (x - 4#32).usubOverflow 64#32 = true) →
    x - 4#32 - 64#32 = x + BitVec.ofInt 32 (-68) :=
sorry