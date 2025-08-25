
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem canonicalize_logic_first_or0_nsw_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬(True ∧ x.saddOverflow 112#32 = true) →
    ¬(True ∧ (x ||| 15#32).saddOverflow 112#32 = true) → x + 112#32 ||| 15#32 = (x ||| 15#32) + 112#32 :=
sorry