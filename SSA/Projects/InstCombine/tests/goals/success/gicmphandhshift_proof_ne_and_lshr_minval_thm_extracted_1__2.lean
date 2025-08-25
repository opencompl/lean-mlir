
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem ne_and_lshr_minval_thm.extracted_1._2 : ∀ (x x_1 : BitVec 8),
  ¬(x ≥ ↑8 ∨ x ≥ ↑8) →
    ¬(True ∧ BitVec.ofInt 8 (-128) >>> x <<< x ≠ BitVec.ofInt 8 (-128) ∨ x ≥ ↑8) →
      ofBool (x_1 * x_1 &&& BitVec.ofInt 8 (-128) >>> x != BitVec.ofInt 8 (-128) >>> x) =
        ofBool (x_1 * x_1 &&& BitVec.ofInt 8 (-128) >>> x == 0#8) :=
sorry