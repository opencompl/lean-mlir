
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem trunc_ashr_trunc_exact_thm.extracted_1._1 : ∀ (x : BitVec 64),
  ¬(True ∧ truncate 32 x >>> 8#32 <<< 8#32 ≠ truncate 32 x ∨ 8#32 ≥ ↑32) →
    True ∧ x >>> 8#64 <<< 8#64 ≠ x ∨ 8#64 ≥ ↑64 → False :=
sorry