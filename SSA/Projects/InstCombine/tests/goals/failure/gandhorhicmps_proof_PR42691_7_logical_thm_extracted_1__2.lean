
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem PR42691_7_logical_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬ofBool (BitVec.ofInt 32 (-2147483647) ≤ᵤ x) = 1#1 → ofBool (x == 0#32) = ofBool (x + -1#32 <ₛ 0#32) :=
sorry