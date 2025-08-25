
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem PR42691_3_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (0#32 ≤ₛ x) ||| ofBool (x == BitVec.ofInt 32 (-2147483648)) = ofBool (x <ᵤ BitVec.ofInt 32 (-2147483647)) :=
sorry