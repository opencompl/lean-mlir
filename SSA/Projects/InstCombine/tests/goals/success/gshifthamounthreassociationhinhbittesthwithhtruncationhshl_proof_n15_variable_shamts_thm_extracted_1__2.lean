
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem n15_variable_shamts_thm.extracted_1._2 : ∀ (x x_1 : BitVec 32) (x_2 x_3 : BitVec 64),
  ¬(x_2 ≥ ↑64 ∨ x ≥ ↑32) →
    ¬(x ≥ ↑32 ∨ x_2 ≥ ↑64) →
      ofBool (truncate 32 (x_3 <<< x_2) &&& x_1 >>> x != 0#32) =
        ofBool (x_1 >>> x &&& truncate 32 (x_3 <<< x_2) != 0#32) :=
sorry