
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem negative_with_wrong_mask_logical_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬ofBool (x &&& 1#32 == 0#32) = 1#1 → 0#1 = ofBool (x &&& 1#32 == 0#32) &&& ofBool (x + 128#32 <ᵤ 256#32) :=
sorry