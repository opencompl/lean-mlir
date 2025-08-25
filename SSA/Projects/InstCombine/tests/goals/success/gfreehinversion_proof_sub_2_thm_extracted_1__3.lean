
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem sub_2_thm.extracted_1._3 : ∀ (x x_1 : BitVec 8) (x_2 : BitVec 1) (x_3 : BitVec 8),
  x_2 = 1#1 → x_3 - (x_1 ^^^ -1#8) ^^^ -1#8 = BitVec.ofInt 8 (-2) - (x_1 + x_3) :=
sorry