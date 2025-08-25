
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test11_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (x &&& 2#32 != 0#32) ||| ofBool (3#32 <ᵤ x) = ofBool (1#32 <ᵤ x) :=
sorry