
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem scalar_i32_shl_ult_const_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬11#32 ≥ ↑32 → ofBool (x <<< 11#32 <ᵤ 131072#32) = ofBool (x &&& 2097088#32 == 0#32) :=
sorry