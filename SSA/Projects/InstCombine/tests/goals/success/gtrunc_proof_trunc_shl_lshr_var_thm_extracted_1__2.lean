
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem trunc_shl_lshr_var_thm.extracted_1._2 : ∀ (x x_1 : BitVec 64),
  ¬(x ≥ ↑64 ∨ 2#64 ≥ ↑64) →
    ¬(x ≥ ↑64 ∨ 2#32 ≥ ↑32) → truncate 32 (x_1 >>> x <<< 2#64) = truncate 32 (x_1 >>> x) <<< 2#32 :=
sorry