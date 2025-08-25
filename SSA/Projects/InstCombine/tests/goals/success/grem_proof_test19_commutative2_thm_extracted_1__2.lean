
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test19_commutative2_thm.extracted_1._2 : ∀ (x x_1 : BitVec 32),
  ¬(x ≥ ↑32 ∨ x_1 ≥ ↑32 ∨ x ≥ ↑32 ∨ 1#32 <<< x + (1#32 <<< x_1 &&& 1#32 <<< x) = 0) →
    ¬(True ∧ 1#32 <<< x >>> x ≠ 1#32 ∨
          x ≥ ↑32 ∨ True ∧ 1#32 <<< x_1 >>> x_1 ≠ 1#32 ∨ x_1 ≥ ↑32 ∨ True ∧ 1#32 <<< x >>> x ≠ 1#32 ∨ x ≥ ↑32) →
      x_1 % (1#32 <<< x + (1#32 <<< x_1 &&& 1#32 <<< x)) = x_1 &&& 1#32 <<< x + (1#32 <<< x_1 &&& 1#32 <<< x) + -1#32 :=
sorry