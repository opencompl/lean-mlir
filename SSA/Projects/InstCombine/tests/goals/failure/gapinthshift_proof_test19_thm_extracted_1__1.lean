
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test19_thm.extracted_1._1 : ∀ (x : BitVec 37),
  ¬2#37 ≥ ↑37 → ofBool (x.sshiftRight' 2#37 == 0#37) = ofBool (x <ᵤ 4#37) :=
sorry