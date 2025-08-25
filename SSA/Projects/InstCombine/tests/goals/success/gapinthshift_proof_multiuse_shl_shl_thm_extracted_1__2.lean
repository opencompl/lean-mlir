
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem multiuse_shl_shl_thm.extracted_1._2 : ∀ (x : BitVec 42),
  ¬(8#42 ≥ ↑42 ∨ 8#42 ≥ ↑42 ∨ 9#42 ≥ ↑42) →
    ¬(8#42 ≥ ↑42 ∨ 17#42 ≥ ↑42) → x <<< 8#42 * x <<< 8#42 <<< 9#42 = x <<< 8#42 * x <<< 17#42 :=
sorry