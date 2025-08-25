
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem scalar_i8_shl_ule_const_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬5#8 ≥ ↑8 → ofBool (x <<< 5#8 ≤ᵤ 63#8) = ofBool (x &&& 6#8 == 0#8) :=
sorry