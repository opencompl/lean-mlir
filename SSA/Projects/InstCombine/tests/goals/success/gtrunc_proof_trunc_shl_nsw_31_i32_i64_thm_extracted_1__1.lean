
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem trunc_shl_nsw_31_i32_i64_thm.extracted_1._1 : ∀ (x : BitVec 64),
  ¬(True ∧ (x <<< 31#64).sshiftRight' 31#64 ≠ x ∨ 31#64 ≥ ↑64) → 31#32 ≥ ↑32 → False :=
sorry