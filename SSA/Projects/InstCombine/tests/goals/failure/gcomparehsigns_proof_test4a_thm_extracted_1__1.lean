
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test4a_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬(31#32 ≥ ↑32 ∨ 31#32 ≥ ↑32) → ofBool (x.sshiftRight' 31#32 ||| (0#32 - x) >>> 31#32 <ₛ 1#32) = ofBool (x <ₛ 1#32) :=
sorry