
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem multiuse_shl_shl_thm.extracted_1._1 : ∀ (x : BitVec 42),
  ¬(8#42 ≥ ↑42 ∨ 8#42 ≥ ↑42 ∨ 9#42 ≥ ↑42) → 8#42 ≥ ↑42 ∨ 17#42 ≥ ↑42 → False :=
sorry