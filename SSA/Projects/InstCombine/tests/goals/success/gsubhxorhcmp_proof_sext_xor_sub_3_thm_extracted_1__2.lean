
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem sext_xor_sub_3_thm.extracted_1._2 : ∀ (x : BitVec 64) (x_1 : BitVec 1),
  ¬x_1 = 1#1 → signExtend 64 x_1 - (signExtend 64 x_1 ^^^ x) = 0#64 - x :=
sorry