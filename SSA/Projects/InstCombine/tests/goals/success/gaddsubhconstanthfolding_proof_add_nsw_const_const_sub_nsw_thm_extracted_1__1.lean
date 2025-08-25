
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem add_nsw_const_const_sub_nsw_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬(True ∧ x.saddOverflow 1#8 = true ∨ True ∧ (BitVec.ofInt 8 (-127)).ssubOverflow (x + 1#8) = true) →
    True ∧ (BitVec.ofInt 8 (-128)).ssubOverflow x = true → False :=
sorry