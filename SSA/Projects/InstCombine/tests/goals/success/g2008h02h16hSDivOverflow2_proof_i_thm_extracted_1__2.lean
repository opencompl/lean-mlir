
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem i_thm.extracted_1._2 : ∀ (x : BitVec 8),
  ¬((BitVec.ofInt 8 (-3) == 0 || 8 != 1 && x == intMin 8 && BitVec.ofInt 8 (-3) == -1) = true ∨
        (BitVec.ofInt 8 (-3) == 0 || 8 != 1 && x.sdiv (BitVec.ofInt 8 (-3)) == intMin 8 && BitVec.ofInt 8 (-3) == -1) =
          true) →
    ¬(9#8 == 0 || 8 != 1 && x == intMin 8 && 9#8 == -1) = true →
      (x.sdiv (BitVec.ofInt 8 (-3))).sdiv (BitVec.ofInt 8 (-3)) = x.sdiv 9#8 :=
sorry