
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem xor_sext_sext_thm.extracted_1._1 : ∀ (x : BitVec 4) (x_1 : BitVec 8),
  signExtend 16 x_1 ^^^ signExtend 16 x = signExtend 16 (x_1 ^^^ signExtend 8 x) :=
sorry