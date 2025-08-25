
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem foo1_and_thm.extracted_1._2 : ∀ (x x_1 x_2 : BitVec 32),
  ¬(x_2 ≥ ↑32 ∨ x ≥ ↑32) →
    ¬(True ∧ 1#32 <<< x_2 >>> x_2 ≠ 1#32 ∨
          x_2 ≥ ↑32 ∨
            True ∧ 1#32 <<< x >>> x ≠ 1#32 ∨
              x ≥ ↑32 ∨ True ∧ 1#32 <<< x_2 >>> x_2 ≠ 1#32 ∨ x_2 ≥ ↑32 ∨ True ∧ 1#32 <<< x >>> x ≠ 1#32 ∨ x ≥ ↑32) →
      ofBool (1#32 <<< x_2 &&& x_1 == 0#32) ||| ofBool (1#32 <<< x &&& x_1 == 0#32) =
        ofBool (x_1 &&& (1#32 <<< x_2 ||| 1#32 <<< x) != 1#32 <<< x_2 ||| 1#32 <<< x) :=
sorry