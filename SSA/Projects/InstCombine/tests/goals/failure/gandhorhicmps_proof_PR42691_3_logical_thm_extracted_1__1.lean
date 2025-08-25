
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem PR42691_3_logical_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (0#32 ≤ₛ x) = 1#1 → 1#1 = ofBool (x <ᵤ BitVec.ofInt 32 (-2147483647)) :=
sorry