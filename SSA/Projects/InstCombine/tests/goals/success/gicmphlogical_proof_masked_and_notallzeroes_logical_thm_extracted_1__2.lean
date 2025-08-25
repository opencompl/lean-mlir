
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem masked_and_notallzeroes_logical_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬ofBool (x &&& 7#32 != 0#32) = 1#1 → 0#1 = ofBool (x &&& 7#32 != 0#32) :=
sorry