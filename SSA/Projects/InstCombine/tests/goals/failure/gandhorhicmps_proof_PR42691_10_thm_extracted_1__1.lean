
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem PR42691_10_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (13#32 <ᵤ x) &&& ofBool (x != -1#32) = ofBool (x + BitVec.ofInt 32 (-14) <ᵤ BitVec.ofInt 32 (-15)) :=
sorry