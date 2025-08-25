
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem scalar_i8_shl_and_negC_eq_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  ¬x ≥ ↑8 → ofBool (x_1 <<< x &&& BitVec.ofInt 8 (-4) == 0#8) = ofBool (x_1 <<< x <ᵤ 4#8) :=
sorry