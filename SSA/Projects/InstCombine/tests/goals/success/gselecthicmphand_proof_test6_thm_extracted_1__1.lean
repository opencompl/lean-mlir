
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test6_thm.extracted_1._1 : ∀ (x : BitVec 1023),
  ofBool (x &&& 64#1023 != 0#1023) = 1#1 → 64#1023 = x &&& 64#1023 :=
sorry