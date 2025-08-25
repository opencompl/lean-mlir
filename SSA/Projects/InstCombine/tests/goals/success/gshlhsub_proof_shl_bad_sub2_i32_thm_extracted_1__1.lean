
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem shl_bad_sub2_i32_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬x - 31#32 ≥ ↑32 →
    True ∧ 1#32 <<< (x + BitVec.ofInt 32 (-31)) >>> (x + BitVec.ofInt 32 (-31)) ≠ 1#32 ∨
        x + BitVec.ofInt 32 (-31) ≥ ↑32 →
      False :=
sorry