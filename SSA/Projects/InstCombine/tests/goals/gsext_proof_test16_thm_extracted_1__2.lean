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

theorem test16_thm.extracted_1._2 : ∀ (x : BitVec 16),
  ¬(12#16 ≥ ↑16 ∨ 15#16 ≥ ↑16) →
    signExtend 32 (ofBool (x &&& 8#16 == 8#16)) = signExtend 32 ((x <<< 12#16).sshiftRight' 15#16) :=
sorry