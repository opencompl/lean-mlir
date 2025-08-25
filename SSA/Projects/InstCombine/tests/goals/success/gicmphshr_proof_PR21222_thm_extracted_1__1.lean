
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem PR21222_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬x ≥ ↑32 → ofBool ((BitVec.ofInt 32 (-93)).sshiftRight' x == BitVec.ofInt 32 (-2)) = ofBool (x == 6#32) :=
sorry