
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem fold_sext_to_and_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ofBool (signExtend 32 x &&& BitVec.ofInt 32 (-2147483647) == 1#32) = ofBool (x &&& BitVec.ofInt 8 (-127) == 1#8) :=
sorry