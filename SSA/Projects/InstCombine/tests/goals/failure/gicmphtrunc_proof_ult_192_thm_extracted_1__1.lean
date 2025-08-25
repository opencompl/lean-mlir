
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem ult_192_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (truncate 8 x <ᵤ BitVec.ofInt 8 (-64)) = ofBool (x &&& 192#32 != 192#32) :=
sorry