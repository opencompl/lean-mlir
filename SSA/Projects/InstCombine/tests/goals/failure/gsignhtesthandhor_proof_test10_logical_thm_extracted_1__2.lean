
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test10_logical_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬ofBool (x &&& 2#32 == 0#32) = 1#1 → 0#1 = ofBool (x <ᵤ 2#32) :=
sorry