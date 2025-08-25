
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬x ≥ ↑32 →
    ¬(True ∧ 1#32 <<< x >>> x ≠ 1#32 ∨ x ≥ ↑32) →
      ofBool (3968#32 >>> x &&& 1#32 == 0#32) = ofBool (1#32 <<< x &&& 3968#32 == 0#32) :=
sorry