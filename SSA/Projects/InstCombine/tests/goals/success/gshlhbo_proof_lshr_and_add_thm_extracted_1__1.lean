
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem lshr_and_add_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  ¬((42#8 == 0 || 8 != 1 && x_1 == intMin 8 && 42#8 == -1) = true ∨ 3#8 ≥ ↑8 ∨ 3#8 ≥ ↑8) →
    (42#8 == 0 || 8 != 1 && x_1 == intMin 8 && 42#8 == -1) = true ∨ 3#8 ≥ ↑8 → False :=
sorry