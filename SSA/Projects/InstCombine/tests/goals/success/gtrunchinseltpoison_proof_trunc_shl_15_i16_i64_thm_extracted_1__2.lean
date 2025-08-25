
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem trunc_shl_15_i16_i64_thm.extracted_1._2 : ∀ (x : BitVec 64),
  ¬15#64 ≥ ↑64 → ¬15#16 ≥ ↑16 → truncate 16 (x <<< 15#64) = truncate 16 x <<< 15#16 :=
sorry