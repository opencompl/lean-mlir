
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem shl_bad_sub_i32_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬32#32 - x ≥ ↑32 → True ∧ 1#32 <<< (32#32 - x) >>> (32#32 - x) ≠ 1#32 ∨ 32#32 - x ≥ ↑32 → False :=
sorry