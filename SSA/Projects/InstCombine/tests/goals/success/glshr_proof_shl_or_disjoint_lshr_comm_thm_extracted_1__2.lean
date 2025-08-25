
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem shl_or_disjoint_lshr_comm_thm.extracted_1._2 : ∀ (x x_1 x_2 : BitVec 32),
  ¬(True ∧ x_1 <<< x >>> x ≠ x_1 ∨ x ≥ ↑32 ∨ True ∧ (x_2 &&& x_1 <<< x != 0) = true ∨ x ≥ ↑32) →
    ¬(x ≥ ↑32 ∨ True ∧ (x_2 >>> x &&& x_1 != 0) = true) → (x_2 ||| x_1 <<< x) >>> x = x_2 >>> x ||| x_1 :=
sorry