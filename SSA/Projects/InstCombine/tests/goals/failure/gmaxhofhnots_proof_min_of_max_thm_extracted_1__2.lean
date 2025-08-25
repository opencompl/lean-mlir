
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem min_of_max_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬ofBool (x <ₛ 0#32) = 1#1 → ofBool (-1#32 <ₛ -1#32) = 1#1 ∧ ofBool (x <ₛ 0#32) = 1#1 → x ^^^ -1#32 = -1#32 :=
sorry