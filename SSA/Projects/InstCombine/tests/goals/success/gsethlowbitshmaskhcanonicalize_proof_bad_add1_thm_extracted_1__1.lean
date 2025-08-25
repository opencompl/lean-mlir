
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem bad_add1_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬x ≥ ↑32 → True ∧ 1#32 <<< x >>> x ≠ 1#32 ∨ x ≥ ↑32 ∨ True ∧ (1#32 <<< x).uaddOverflow 1#32 = true → False :=
sorry