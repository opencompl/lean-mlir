
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem canonicalize_logic_first_and0_nsw_thm.extracted_1._2 : ∀ (x : BitVec 8),
  ¬(True ∧ x.saddOverflow 48#8 = true) →
    ¬(True ∧ (x &&& BitVec.ofInt 8 (-10)).saddOverflow 48#8 = true) →
      x + 48#8 &&& BitVec.ofInt 8 (-10) = (x &&& BitVec.ofInt 8 (-10)) + 48#8 :=
sorry