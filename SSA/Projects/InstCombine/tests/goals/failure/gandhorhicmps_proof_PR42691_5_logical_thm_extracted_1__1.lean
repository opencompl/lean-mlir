
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem PR42691_5_logical_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (x <ₛ 1#32) = 1#1 → 1#1 = ofBool (x + BitVec.ofInt 32 (-2147483647) <ᵤ BitVec.ofInt 32 (-2147483646)) :=
sorry