
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem n1_thm.extracted_1._2 : ∀ (x x_1 : BitVec 8),
  ¬x_1 ≥ ↑8 →
    ¬(True ∧ 1#8 <<< x_1 >>> x_1 ≠ 1#8 ∨ x_1 ≥ ↑8) →
      ofBool ((1#8 <<< x_1 ^^^ -1#8) &&& x != x) = ofBool (x &&& 1#8 <<< x_1 != 0#8) :=
sorry