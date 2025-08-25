
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test9_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (x &&& 1073741824#32 != 0#32) &&& ofBool (-1#32 <ₛ x) =
    ofBool (x &&& BitVec.ofInt 32 (-1073741824) == 1073741824#32) :=
sorry