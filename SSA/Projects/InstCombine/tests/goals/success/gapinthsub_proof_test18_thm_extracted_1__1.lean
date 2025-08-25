
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test18_thm.extracted_1._1 : ∀ (x : BitVec 128),
  ¬(2#128 ≥ ↑128 ∨ 2#128 ≥ ↑128) → x <<< 2#128 - x <<< 2#128 = 0#128 :=
sorry