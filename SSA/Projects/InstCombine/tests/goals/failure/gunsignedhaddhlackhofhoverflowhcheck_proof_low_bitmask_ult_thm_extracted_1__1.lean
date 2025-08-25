
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem low_bitmask_ult_thm.extracted_1._1 : ∀ (x : BitVec 8), ofBool (x + 31#8 &&& 31#8 <ᵤ x) = ofBool (x != 0#8) :=
sorry