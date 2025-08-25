
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem scalar_i8_shl_ult_const_2_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬6#8 ≥ ↑8 → ofBool (x <<< 6#8 <ᵤ 64#8) = ofBool (x &&& 3#8 == 0#8) :=
sorry