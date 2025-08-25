
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test66_thm.extracted_1._1 : ∀ (x : BitVec 64),
  ofBool (x &&& 4294967296#64 != 0#64) = 1#1 → ofBool (x &&& 4294967296#64 == 0#64) = 1#1 → 40#32 = 42#32 :=
sorry