
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem trunc_shl_1_i32_i64_thm.extracted_1._2 : ∀ (x : BitVec 64),
  ¬1#64 ≥ ↑64 → ¬1#32 ≥ ↑32 → truncate 32 (x <<< 1#64) = truncate 32 x <<< 1#32 :=
sorry