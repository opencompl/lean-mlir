
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem negate_sdiv_thm.extracted_1._2 : ∀ (x x_1 : BitVec 8),
  ¬(42#8 == 0 || 8 != 1 && x == intMin 8 && 42#8 == -1) = true →
    ¬(BitVec.ofInt 8 (-42) == 0 || 8 != 1 && x == intMin 8 && BitVec.ofInt 8 (-42) == -1) = true →
      x_1 - x.sdiv 42#8 = x.sdiv (BitVec.ofInt 8 (-42)) + x_1 :=
sorry