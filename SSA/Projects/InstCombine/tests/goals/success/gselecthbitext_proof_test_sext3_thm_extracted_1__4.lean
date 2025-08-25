
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test_sext3_thm.extracted_1._4 : ∀ (x x_1 : BitVec 1),
  x_1 = 1#1 → ¬x_1 ^^^ 1#1 = 1#1 → 0#32 = signExtend 32 0#1 :=
sorry