
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem trunc_shl_15_i16_i32_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬15#32 ≥ ↑32 → ¬15#16 ≥ ↑16 → truncate 16 (x <<< 15#32) = truncate 16 x <<< 15#16 :=
sorry