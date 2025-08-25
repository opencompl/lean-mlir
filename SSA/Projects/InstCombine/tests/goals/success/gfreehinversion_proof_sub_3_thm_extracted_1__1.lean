
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem sub_3_thm.extracted_1._1 : ∀ (x : BitVec 128) (x_1 : BitVec 1) (x_2 : BitVec 128),
  x_1 = 1#1 → x_2 - (x ^^^ -1#128) ^^^ -1#128 = BitVec.ofInt 128 (-2) - (x + x_2) :=
sorry