
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem sext_non_bool_xor_sub_1_thm.extracted_1._1 : ∀ (x : BitVec 64) (x_1 : BitVec 8),
  (signExtend 64 x_1 ^^^ x) - signExtend 64 x_1 = (x ^^^ signExtend 64 x_1) - signExtend 64 x_1 :=
sorry