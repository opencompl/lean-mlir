
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem positive_different_trunc_both_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (-1#15 <ₛ truncate 15 x) &&& ofBool (truncate 16 x + 128#16 <ᵤ 256#16) =
    ofBool (x &&& 16384#32 == 0#32) &&& ofBool (truncate 16 x + 128#16 <ᵤ 256#16) :=
sorry