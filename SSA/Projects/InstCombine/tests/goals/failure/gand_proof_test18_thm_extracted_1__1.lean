
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test18_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (x &&& BitVec.ofInt 32 (-128) != 0#32) = ofBool (127#32 <ᵤ x) :=
sorry