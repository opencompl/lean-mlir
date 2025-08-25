
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem or_nontrivial_mask1_thm.extracted_1._1 : ∀ (x : BitVec 16),
  ofBool (truncate 8 x != 127#8) ||| ofBool (x &&& 3840#16 != 1280#16) = ofBool (x &&& 4095#16 != 1407#16) :=
sorry