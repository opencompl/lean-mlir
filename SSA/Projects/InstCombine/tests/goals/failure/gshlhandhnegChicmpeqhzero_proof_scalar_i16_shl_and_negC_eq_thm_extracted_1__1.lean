
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem scalar_i16_shl_and_negC_eq_thm.extracted_1._1 : ∀ (x x_1 : BitVec 16),
  ¬x ≥ ↑16 → ofBool (x_1 <<< x &&& BitVec.ofInt 16 (-128) == 0#16) = ofBool (x_1 <<< x <ᵤ 128#16) :=
sorry