
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem masked_and_notA_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (x &&& 14#32 != x) &&& ofBool (x &&& 78#32 != x) = ofBool (x &&& BitVec.ofInt 32 (-79) != 0#32) :=
sorry