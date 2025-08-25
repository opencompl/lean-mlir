
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem pr9998_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬(31#32 ≥ ↑32 ∨ True ∧ x <<< 31#32 >>> 31#32 <<< 31#32 ≠ x <<< 31#32 ∨ 31#32 ≥ ↑32) →
    ofBool (7297771788697658747#64 <ᵤ signExtend 64 ((x <<< 31#32).sshiftRight' 31#32)) = ofBool (x &&& 1#32 != 0#32) :=
sorry