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

theorem PR56294_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ofBool (zeroExtend 32 (ofBool (x == 2#8)) &&& zeroExtend 32 (x &&& 1#8) != 0#32) = 0#1 :=
sorry