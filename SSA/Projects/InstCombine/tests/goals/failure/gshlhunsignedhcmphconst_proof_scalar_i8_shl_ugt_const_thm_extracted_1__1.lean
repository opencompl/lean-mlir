
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem scalar_i8_shl_ugt_const_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬5#8 ≥ ↑8 → ofBool (63#8 <ᵤ x <<< 5#8) = ofBool (x &&& 6#8 != 0#8) :=
sorry