
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem reassoc_mul_nuw_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬(True ∧ x.umulOverflow 4#32 = true ∨ True ∧ (x * 4#32).umulOverflow 65#32 = true) →
    ¬(True ∧ x.umulOverflow 260#32 = true) → x * 4#32 * 65#32 = x * 260#32 :=
sorry