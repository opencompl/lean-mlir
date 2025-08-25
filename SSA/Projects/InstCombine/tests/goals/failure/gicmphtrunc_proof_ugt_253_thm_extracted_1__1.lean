
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem ugt_253_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (BitVec.ofInt 8 (-3) <ᵤ truncate 8 x) = ofBool (x &&& 254#32 == 254#32) :=
sorry