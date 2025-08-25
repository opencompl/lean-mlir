
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem lshr_and_thm.extracted_1._1 : ∀ (x x_1 : BitVec 64),
  ¬((42#64 == 0 || 64 != 1 && x_1 == intMin 64 && 42#64 == -1) = true ∨ 5#64 ≥ ↑64 ∨ 7#64 ≥ ↑64) →
    12#64 ≥ ↑64 ∨ (42#64 == 0 || 64 != 1 && x_1 == intMin 64 && 42#64 == -1) = true ∨ 7#64 ≥ ↑64 → False :=
sorry