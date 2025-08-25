
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem PR1817_2_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (x <ₛ 10#32) ||| ofBool (x <ᵤ 10#32) = ofBool (x <ₛ 10#32) :=
sorry