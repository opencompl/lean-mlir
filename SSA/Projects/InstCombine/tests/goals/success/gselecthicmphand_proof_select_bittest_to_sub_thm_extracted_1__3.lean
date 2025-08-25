
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem select_bittest_to_sub_thm.extracted_1._3 : ∀ (x : BitVec 32),
  ¬ofBool (x &&& 1#32 == 0#32) = 1#1 →
    True ∧ (4#32).ssubOverflow (x &&& 1#32) = true ∨ True ∧ (4#32).usubOverflow (x &&& 1#32) = true → False :=
sorry