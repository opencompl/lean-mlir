
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem scalar_i16_shl_ult_const_thm.extracted_1._1 : ∀ (x : BitVec 16),
  ¬8#16 ≥ ↑16 → ofBool (x <<< 8#16 <ᵤ 1024#16) = ofBool (x &&& 252#16 == 0#16) :=
sorry