
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test16_thm.extracted_1._2 : ∀ (x : BitVec 51),
  ¬(1123#51 == 0 || 51 != 1 && x == intMin 51 && 1123#51 == -1) = true →
    ¬(BitVec.ofInt 51 (-1123) == 0 || 51 != 1 && x == intMin 51 && BitVec.ofInt 51 (-1123) == -1) = true →
      0#51 - x.sdiv 1123#51 = x.sdiv (BitVec.ofInt 51 (-1123)) :=
sorry