
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem select_bittest_to_add_thm.extracted_1._3 : ∀ (x : BitVec 32),
  ¬ofBool (x &&& 1#32 == 0#32) = 1#1 →
    True ∧ (x &&& 1#32).saddOverflow 3#32 = true ∨ True ∧ (x &&& 1#32).uaddOverflow 3#32 = true → False :=
sorry