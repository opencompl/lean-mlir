
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem PR42691_1_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (x <ₛ 0#32) ||| ofBool (x == 2147483647#32) = ofBool (2147483646#32 <ᵤ x) :=
sorry