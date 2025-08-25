
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem ashr_xor_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ¬((42#32 == 0 || 32 != 1 && x_1 == intMin 32 && 42#32 == -1) = true ∨ 5#32 ≥ ↑32 ∨ 7#32 ≥ ↑32) →
    12#32 ≥ ↑32 ∨ (42#32 == 0 || 32 != 1 && x_1 == intMin 32 && 42#32 == -1) = true ∨ 7#32 ≥ ↑32 → False :=
sorry