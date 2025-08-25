
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test_sext_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  x_1 + signExtend 32 (ofBool (x == 0#32)) ^^^ -1#32 = signExtend 32 (ofBool (x != 0#32)) - x_1 :=
sorry