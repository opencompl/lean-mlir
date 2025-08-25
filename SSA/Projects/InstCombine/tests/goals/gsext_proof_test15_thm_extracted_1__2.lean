
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000
set_option Elab.async false
-/

theorem test15_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬(27#32 ≥ ↑32 ∨ 31#32 ≥ ↑32) → signExtend 32 (ofBool (x &&& 16#32 != 0#32)) = (x <<< 27#32).sshiftRight' 31#32 :=
sorry