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

theorem test10_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬(6#8 ≥ ↑8 ∨ 6#8 ≥ ↑8) →
    ¬(30#32 ≥ ↑32 ∨ True ∧ x <<< 30#32 >>> 30#32 <<< 30#32 ≠ x <<< 30#32 ∨ 30#32 ≥ ↑32) →
      signExtend 32 ((truncate 8 x <<< 6#8).sshiftRight' 6#8) = (x <<< 30#32).sshiftRight' 30#32 :=
sorry