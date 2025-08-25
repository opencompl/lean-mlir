
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem sext_xor_sub_thm.extracted_1._1 : ∀ (x : BitVec 1) (x_1 : BitVec 64),
  x = 1#1 → (x_1 ^^^ signExtend 64 x) - signExtend 64 x = 0#64 - x_1 :=
sorry