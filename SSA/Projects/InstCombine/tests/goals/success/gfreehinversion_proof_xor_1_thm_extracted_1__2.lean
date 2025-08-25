
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem xor_1_thm.extracted_1._2 : ∀ (x x_1 : BitVec 8) (x_2 : BitVec 1),
  ¬x_2 = 1#1 → x_1 ^^^ 123#8 ^^^ x ^^^ -1#8 = x_1 ^^^ BitVec.ofInt 8 (-124) ^^^ x :=
sorry