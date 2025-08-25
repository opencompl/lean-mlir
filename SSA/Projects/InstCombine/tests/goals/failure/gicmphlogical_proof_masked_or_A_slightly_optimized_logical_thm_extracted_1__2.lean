
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem masked_or_A_slightly_optimized_logical_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬ofBool (x <ᵤ 8#32) = 1#1 → ofBool (x &&& 39#32 == x) = ofBool (x &&& BitVec.ofInt 32 (-40) == 0#32) :=
sorry