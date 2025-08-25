
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem shl1_trunc_sgt4_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬x ≥ ↑32 → True ∧ 1#32 <<< x >>> x ≠ 1#32 ∨ x ≥ ↑32 → False :=
sorry