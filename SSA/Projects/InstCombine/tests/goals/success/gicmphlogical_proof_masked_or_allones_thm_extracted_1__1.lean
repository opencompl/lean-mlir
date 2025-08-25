
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem masked_or_allones_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (x &&& 7#32 == 7#32) ||| ofBool (x &&& 39#32 == 39#32) = ofBool (x &&& 7#32 == 7#32) :=
sorry