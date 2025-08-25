
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem main_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬(6#8 ≥ ↑8 ∨ 7#8 ≥ ↑8) → 5#8 ≥ ↑8 ∨ True ∧ ((truncate 8 x ^^^ -1#8) <<< 5#8 &&& 64#8).msb = true → False :=
sorry