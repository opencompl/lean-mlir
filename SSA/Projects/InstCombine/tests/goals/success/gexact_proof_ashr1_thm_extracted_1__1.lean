
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem ashr1_thm.extracted_1._1 : ∀ (x : BitVec 64),
  ¬(8#64 ≥ ↑64 ∨ 2#64 ≥ ↑64) → 8#64 ≥ ↑64 ∨ True ∧ x <<< 8#64 >>> 2#64 <<< 2#64 ≠ x <<< 8#64 ∨ 2#64 ≥ ↑64 → False :=
sorry