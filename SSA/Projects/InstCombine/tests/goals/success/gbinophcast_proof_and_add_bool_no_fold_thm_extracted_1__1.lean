
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem and_add_bool_no_fold_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (x &&& 1#32 == 0#32) = 1#1 → -1#32 + (x &&& 1#32) &&& x = x :=
sorry