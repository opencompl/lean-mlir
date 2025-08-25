
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem fold_sext_to_and_wrong10_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ofBool (signExtend 32 x &&& BitVec.ofInt 32 (-256) != 1#32) = 1#1 :=
sorry