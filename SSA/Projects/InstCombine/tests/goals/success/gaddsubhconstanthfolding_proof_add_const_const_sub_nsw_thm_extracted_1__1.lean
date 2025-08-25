
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem add_const_const_sub_nsw_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬(True ∧ (BitVec.ofInt 8 (-127)).ssubOverflow (x + 1#8) = true) →
    BitVec.ofInt 8 (-127) - (x + 1#8) = BitVec.ofInt 8 (-128) - x :=
sorry