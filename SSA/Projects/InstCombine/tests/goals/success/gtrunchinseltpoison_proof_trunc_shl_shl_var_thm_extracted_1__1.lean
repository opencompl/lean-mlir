
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem trunc_shl_shl_var_thm.extracted_1._1 : ∀ (x x_1 : BitVec 64),
  ¬(x ≥ ↑64 ∨ 2#64 ≥ ↑64) → x ≥ ↑64 ∨ 2#32 ≥ ↑32 → False :=
sorry