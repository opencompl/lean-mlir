
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test23_logical_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (1#32 <ₛ x) = 1#1 → ofBool (x ≤ₛ 2#32) = ofBool (x == 2#32) :=
sorry