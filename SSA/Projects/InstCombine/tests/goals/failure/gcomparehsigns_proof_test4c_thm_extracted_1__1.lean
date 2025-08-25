
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test4c_thm.extracted_1._1 : ∀ (x : BitVec 64),
  ¬(63#64 ≥ ↑64 ∨ 63#64 ≥ ↑64) →
    ofBool (truncate 32 (x.sshiftRight' 63#64 ||| (0#64 - x) >>> 63#64) <ₛ 1#32) = ofBool (x <ₛ 1#64) :=
sorry