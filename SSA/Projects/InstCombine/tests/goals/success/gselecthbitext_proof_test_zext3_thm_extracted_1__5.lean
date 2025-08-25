
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test_zext3_thm.extracted_1._5 : ∀ (x x_1 : BitVec 1),
  ¬x_1 = 1#1 → ¬x_1 ^^^ 1#1 = 1#1 → zeroExtend 32 x = zeroExtend 32 0#1 :=
sorry