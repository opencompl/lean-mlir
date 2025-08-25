
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem low_bitmask_ugt_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ofBool (x * x + 127#8 &&& 127#8 <ᵤ x * x) = ofBool (x * x != 0#8) :=
sorry