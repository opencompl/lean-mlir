
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem sub_2_thm.extracted_1._2 : ∀ (x : BitVec 8) (x_1 : BitVec 1) (x_2 : BitVec 8),
  ¬x_1 = 1#1 → x_2 - (x ^^^ 123#8) ^^^ -1#8 = BitVec.ofInt 8 (-2) - ((x ^^^ BitVec.ofInt 8 (-124)) + x_2) :=
sorry