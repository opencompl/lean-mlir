
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem trunc_shl_16_i32_i64_thm.extracted_1._2 : ∀ (x : BitVec 64),
  ¬16#64 ≥ ↑64 → ¬16#32 ≥ ↑32 → truncate 32 (x <<< 16#64) = truncate 32 x <<< 16#32 :=
sorry