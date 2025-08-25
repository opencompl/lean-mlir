
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem fold_sext_to_and3_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ofBool (signExtend 32 x &&& 1073741826#32 != 2#32) = ofBool (x &&& BitVec.ofInt 8 (-126) != 2#8) :=
sorry