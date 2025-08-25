
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test_sext4_thm.extracted_1._4 : ∀ (x x_1 : BitVec 1),
  ¬x_1 = 1#1 → x_1 ^^^ 1#1 = 1#1 → -1#32 = signExtend 32 1#1 :=
sorry