
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test_thm.extracted_1._1 : ∀ (x : BitVec 64),
  ¬(16#64 ≥ ↑64 ∨ 16#64 ≥ ↑64) →
    16#64 ≥ ↑64 ∨ True ∧ x <<< 16#64 >>> 16#64 <<< 16#64 ≠ x <<< 16#64 ∨ 16#64 ≥ ↑64 → False :=
sorry