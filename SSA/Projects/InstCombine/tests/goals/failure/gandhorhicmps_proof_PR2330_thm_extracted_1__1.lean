
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem PR2330_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ofBool (x_1 <ᵤ 8#32) &&& ofBool (x <ᵤ 8#32) = ofBool (x_1 ||| x <ᵤ 8#32) :=
sorry