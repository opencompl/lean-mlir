
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem c_thm.extracted_1._1 : ¬(BitVec.ofInt 32 (-3) == 0 ||
        32 != 1 && 0#32 - BitVec.ofInt 32 (-2147483648) == intMin 32 && BitVec.ofInt 32 (-3) == -1) =
      true →
  (0#32 - BitVec.ofInt 32 (-2147483648)).sdiv (BitVec.ofInt 32 (-3)) = 715827882#32 :=
sorry