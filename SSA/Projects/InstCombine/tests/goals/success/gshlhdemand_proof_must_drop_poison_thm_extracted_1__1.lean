
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem must_drop_poison_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ¬(True ∧ ((x_1 &&& 255#32) <<< x).sshiftRight' x ≠ x_1 &&& 255#32 ∨
        True ∧ (x_1 &&& 255#32) <<< x >>> x ≠ x_1 &&& 255#32 ∨ x ≥ ↑32) →
    x ≥ ↑32 → False :=
sorry