
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test_thm.extracted_1._1 : ¬(BitVec.ofInt 32 (-2147483648) == 0 ||
        32 != 1 && 0#32 == intMin 32 && BitVec.ofInt 32 (-2147483648) == -1) =
      true →
  ofBool ((0#32).sdiv (BitVec.ofInt 32 (-2147483648)) == 0#32) = 1#1 :=
sorry