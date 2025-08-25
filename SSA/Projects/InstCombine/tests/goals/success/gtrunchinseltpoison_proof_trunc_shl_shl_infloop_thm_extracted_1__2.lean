
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem trunc_shl_shl_infloop_thm.extracted_1._2 : ∀ (x : BitVec 64),
  ¬(1#64 ≥ ↑64 ∨ 2#64 ≥ ↑64) → ¬3#32 ≥ ↑32 → truncate 32 (x <<< 1#64 <<< 2#64) = truncate 32 x <<< 3#32 :=
sorry