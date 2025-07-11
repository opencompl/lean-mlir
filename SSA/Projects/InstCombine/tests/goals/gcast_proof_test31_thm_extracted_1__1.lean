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

theorem test31_thm.extracted_1._1 : ∀ (x : BitVec 64),
  ofBool (truncate 32 x &&& 42#32 == 10#32) = ofBool (x &&& 42#64 == 10#64) :=
sorry