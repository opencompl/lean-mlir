
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem PR42691_4_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (BitVec.ofInt 32 (-2147483648) ≤ᵤ x) ||| ofBool (x == 0#32) = ofBool (x <ₛ 1#32) :=
sorry