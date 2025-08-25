
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem p0_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  ¬x_1 ≥ ↑8 → ofBool ((-1#8) >>> x_1 &&& x == x) = ofBool (x ≤ᵤ (-1#8) >>> x_1) :=
sorry