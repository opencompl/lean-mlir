
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test11_logical_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬ofBool (x &&& 2#32 != 0#32) = 1#1 → ofBool (3#32 <ᵤ x) = ofBool (1#32 <ᵤ x) :=
sorry