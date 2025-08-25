
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem PR20945_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬x ≥ ↑32 → ofBool ((BitVec.ofInt 32 (-9)).sshiftRight' x != BitVec.ofInt 32 (-5)) = ofBool (x != 1#32) :=
sorry