
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem and_ugt_to_mask_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ofBool (BitVec.ofInt 8 (-5) <ᵤ x) &&& ofBool (x &&& 2#8 == 0#8) =
    ofBool (x &&& BitVec.ofInt 8 (-2) == BitVec.ofInt 8 (-4)) :=
sorry