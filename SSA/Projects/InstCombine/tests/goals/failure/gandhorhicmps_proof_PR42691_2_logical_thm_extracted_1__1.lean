
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem PR42691_2_logical_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (x <ᵤ BitVec.ofInt 32 (-2147483648)) = 1#1 → 1#1 = ofBool (BitVec.ofInt 32 (-2) <ₛ x) :=
sorry