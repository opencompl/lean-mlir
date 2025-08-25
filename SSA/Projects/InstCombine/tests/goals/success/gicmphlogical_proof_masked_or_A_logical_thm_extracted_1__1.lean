
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem masked_or_A_logical_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (x &&& 14#32 == x) = 1#1 → 1#1 = ofBool (x &&& BitVec.ofInt 32 (-79) == 0#32) :=
sorry