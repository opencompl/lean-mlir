
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem mul_unkV_evenC_ne_thm.extracted_1._1 : ∀ (x : BitVec 64),
  ofBool (x * 4#64 != 0#64) = ofBool (x &&& 4611686018427387903#64 != 0#64) :=
sorry