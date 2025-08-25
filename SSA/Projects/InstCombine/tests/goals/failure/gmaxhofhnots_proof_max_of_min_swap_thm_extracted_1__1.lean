
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem max_of_min_swap_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬ofBool (x <ₛ 0#32) = 1#1 → ofBool (-1#32 <ₛ x ^^^ -1#32) = 1#1 → x ^^^ -1#32 = -1#32 :=
sorry