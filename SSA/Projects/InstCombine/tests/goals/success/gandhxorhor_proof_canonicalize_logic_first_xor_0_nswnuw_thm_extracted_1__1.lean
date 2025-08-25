
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem canonicalize_logic_first_xor_0_nswnuw_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬(True ∧ x.saddOverflow 96#8 = true ∨ True ∧ x.uaddOverflow 96#8 = true) →
    True ∧ (x ^^^ 31#8).saddOverflow 96#8 = true ∨ True ∧ (x ^^^ 31#8).uaddOverflow 96#8 = true → False :=
sorry