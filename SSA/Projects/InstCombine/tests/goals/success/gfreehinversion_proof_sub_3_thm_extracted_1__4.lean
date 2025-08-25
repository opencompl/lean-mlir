
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem sub_3_thm.extracted_1._4 : ∀ (x x_1 : BitVec 128) (x_2 : BitVec 1) (x_3 : BitVec 128),
  ¬x_2 = 1#1 → x_3 - (x ^^^ 123#128) ^^^ -1#128 = BitVec.ofInt 128 (-2) - ((x ^^^ BitVec.ofInt 128 (-124)) + x_3) :=
sorry