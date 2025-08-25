
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem negate_sdiv_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  ¬(42#8 == 0 || 8 != 1 && x == intMin 8 && 42#8 == -1) = true →
    (BitVec.ofInt 8 (-42) == 0 || 8 != 1 && x == intMin 8 && BitVec.ofInt 8 (-42) == -1) = true → False :=
sorry