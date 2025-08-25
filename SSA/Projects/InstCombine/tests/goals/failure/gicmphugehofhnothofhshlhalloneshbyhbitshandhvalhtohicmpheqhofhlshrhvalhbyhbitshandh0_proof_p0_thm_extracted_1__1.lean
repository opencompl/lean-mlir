
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem p0_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  ¬x_1 ≥ ↑8 → ofBool (x ≤ᵤ (-1#8) <<< x_1 ^^^ -1#8) = ofBool (x >>> x_1 == 0#8) :=
sorry