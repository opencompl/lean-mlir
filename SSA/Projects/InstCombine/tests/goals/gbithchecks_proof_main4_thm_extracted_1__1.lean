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

theorem main4_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (x &&& 7#32 == 7#32) &&& ofBool (x &&& 48#32 == 48#32) = 1#1 →
    0#32 = zeroExtend 32 (ofBool (x &&& 55#32 != 55#32)) :=
sorry