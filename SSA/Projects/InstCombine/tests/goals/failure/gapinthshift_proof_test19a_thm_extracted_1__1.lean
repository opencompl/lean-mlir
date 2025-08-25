
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test19a_thm.extracted_1._1 : ∀ (x : BitVec 39),
  ¬2#39 ≥ ↑39 → ofBool (x.sshiftRight' 2#39 == -1#39) = ofBool (BitVec.ofInt 39 (-5) <ᵤ x) :=
sorry