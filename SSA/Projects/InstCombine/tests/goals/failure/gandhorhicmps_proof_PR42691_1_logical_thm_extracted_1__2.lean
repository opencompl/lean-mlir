
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem PR42691_1_logical_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬ofBool (x <ₛ 0#32) = 1#1 → ofBool (x == 2147483647#32) = ofBool (2147483646#32 <ᵤ x) :=
sorry