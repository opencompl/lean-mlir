
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem shl1_trunc_sgt0_thm.extracted_1._1 : ∀ (x : BitVec 9),
  ¬x ≥ ↑9 → True ∧ 1#9 <<< x >>> x ≠ 1#9 ∨ x ≥ ↑9 → False :=
sorry