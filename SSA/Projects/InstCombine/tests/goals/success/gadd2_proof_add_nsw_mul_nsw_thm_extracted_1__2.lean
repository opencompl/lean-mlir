
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem add_nsw_mul_nsw_thm.extracted_1._2 : ∀ (x : BitVec 16),
  ¬(True ∧ x.saddOverflow x = true ∨ True ∧ (x + x).saddOverflow x = true) →
    ¬(True ∧ x.smulOverflow 3#16 = true) → x + x + x = x * 3#16 :=
sorry