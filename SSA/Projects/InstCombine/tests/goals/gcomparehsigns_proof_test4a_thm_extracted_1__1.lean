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

theorem test4a_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬(31#32 ≥ ↑32 ∨ 31#32 ≥ ↑32) → ofBool (x.sshiftRight' 31#32 ||| (0#32 - x) >>> 31#32 <ₛ 1#32) = ofBool (x <ₛ 1#32) :=
sorry