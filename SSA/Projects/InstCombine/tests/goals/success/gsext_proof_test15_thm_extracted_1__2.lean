
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test15_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬(27#32 ≥ ↑32 ∨ 31#32 ≥ ↑32) → signExtend 32 (ofBool (x &&& 16#32 != 0#32)) = (x <<< 27#32).sshiftRight' 31#32 :=
sorry