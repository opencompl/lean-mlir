
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem fold_sext_to_and_wrong8_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ofBool (signExtend 32 x &&& 128#32 != BitVec.ofInt 32 (-2147483648)) = 1#1 :=
sorry