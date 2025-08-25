
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem PR28476_logical_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬ofBool (x != 0#32) = 1#1 → ¬ofBool (x == 0#32) = 1#1 → False :=
sorry