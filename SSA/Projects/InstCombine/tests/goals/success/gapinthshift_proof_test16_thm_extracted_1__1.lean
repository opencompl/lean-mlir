
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test16_thm.extracted_1._1 : ∀ (x : BitVec 84),
  ¬4#84 ≥ ↑84 → ofBool (x.sshiftRight' 4#84 &&& 1#84 != 0#84) = ofBool (x &&& 16#84 != 0#84) :=
sorry