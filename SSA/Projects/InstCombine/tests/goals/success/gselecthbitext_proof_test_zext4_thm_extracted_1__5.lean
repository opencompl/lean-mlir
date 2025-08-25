
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test_zext4_thm.extracted_1._5 : ∀ (x x_1 : BitVec 1),
  ¬x_1 = 1#1 → ¬x_1 ^^^ 1#1 = 1#1 → 1#32 = zeroExtend 32 x :=
sorry