
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem canonicalize_logic_first_or0_nswnuw_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬(True ∧ x.saddOverflow 112#32 = true ∨ True ∧ x.uaddOverflow 112#32 = true) →
    True ∧ (x ||| 15#32).saddOverflow 112#32 = true ∨ True ∧ (x ||| 15#32).uaddOverflow 112#32 = true → False :=
sorry