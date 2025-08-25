
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem PR60818_eq_commuted_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (x * 43#32 == 0#32 - x * 43#32) = ofBool (x * 43#32 &&& 2147483647#32 == 0#32) :=
sorry