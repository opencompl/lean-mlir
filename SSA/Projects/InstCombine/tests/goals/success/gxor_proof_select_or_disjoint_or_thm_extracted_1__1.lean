
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem select_or_disjoint_or_thm.extracted_1._1 : ∀ (x : BitVec 32) (x_1 : BitVec 1),
  x_1 = 1#1 →
    ¬(4#32 ≥ ↑32 ∨ True ∧ (0#32 &&& x <<< 4#32 != 0) = true) →
      4#32 ≥ ↑32 ∨
          True ∧ (0#32 &&& x <<< 4#32 != 0) = true ∨
            True ∧ (0#32 ||| x <<< 4#32).saddOverflow 4#32 = true ∨
              True ∧ (0#32 ||| x <<< 4#32).uaddOverflow 4#32 = true →
        False :=
sorry