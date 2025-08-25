
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem bad_shl2_sub_i32_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬x - 31#32 ≥ ↑32 →
    ¬(True ∧ 1#32 <<< (x + BitVec.ofInt 32 (-31)) >>> (x + BitVec.ofInt 32 (-31)) ≠ 1#32 ∨
          x + BitVec.ofInt 32 (-31) ≥ ↑32) →
      1#32 <<< (x - 31#32) = 1#32 <<< (x + BitVec.ofInt 32 (-31)) :=
sorry