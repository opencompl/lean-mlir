
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem masked_and_notA_slightly_optimized_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (8#32 ≤ᵤ x) &&& ofBool (x &&& 39#32 != x) = ofBool (x &&& BitVec.ofInt 32 (-40) != 0#32) :=
sorry