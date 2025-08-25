
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem sext_multi_uses_thm.extracted_1._1 : ∀ (x : BitVec 64) (x_1 : BitVec 1) (x_2 : BitVec 64),
  x_1 = 1#1 → x_2 * signExtend 64 x_1 + ((x ^^^ signExtend 64 x_1) - signExtend 64 x_1) = 0#64 - (x_2 + x) :=
sorry