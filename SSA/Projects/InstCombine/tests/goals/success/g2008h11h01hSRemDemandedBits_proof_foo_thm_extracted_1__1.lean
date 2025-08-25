
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem foo_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬(-1#32 == 0 || 32 != 1 && x == intMin 32 && -1#32 == -1) = true → ofBool (x.srem (-1#32) == 0#32) = 1#1 :=
sorry