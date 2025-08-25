
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem demorgan_nor_use2c_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  ¬((x_1 ^^^ -1#8 ||| x) * 23#8 == 0 ||
          8 != 1 && (x_1 ^^^ -1#8 ||| x) ^^^ -1#8 == intMin 8 && (x_1 ^^^ -1#8 ||| x) * 23#8 == -1) =
        true →
    ((x ||| x_1 ^^^ -1#8) * 23#8 == 0 ||
          8 != 1 && (x ||| x_1 ^^^ -1#8) ^^^ -1#8 == intMin 8 && (x ||| x_1 ^^^ -1#8) * 23#8 == -1) =
        true →
      False :=
sorry