
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem PR42691_9_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (13#32 <ₛ x) &&& ofBool (x != 2147483647#32) = ofBool (x + BitVec.ofInt 32 (-14) <ᵤ 2147483633#32) :=
sorry