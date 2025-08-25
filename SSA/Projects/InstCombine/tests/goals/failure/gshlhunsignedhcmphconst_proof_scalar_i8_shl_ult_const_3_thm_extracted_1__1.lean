
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem scalar_i8_shl_ult_const_3_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬7#8 ≥ ↑8 → ofBool (x <<< 7#8 <ᵤ 64#8) = ofBool (x &&& 1#8 == 0#8) :=
sorry