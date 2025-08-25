
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem canonicalize_logic_first_and0_nswnuw_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬(True ∧ x.saddOverflow 48#8 = true ∨ True ∧ x.uaddOverflow 48#8 = true) →
    True ∧ (x &&& BitVec.ofInt 8 (-10)).saddOverflow 48#8 = true ∨
        True ∧ (x &&& BitVec.ofInt 8 (-10)).uaddOverflow 48#8 = true →
      False :=
sorry