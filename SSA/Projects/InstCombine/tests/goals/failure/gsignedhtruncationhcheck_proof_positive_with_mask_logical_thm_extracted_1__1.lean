
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem positive_with_mask_logical_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (x &&& 1107296256#32 == 0#32) = 1#1 → ofBool (x + 128#32 <ᵤ 256#32) = ofBool (x <ᵤ 128#32) :=
sorry