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

theorem t2_thm.extracted_1._1 : ∀ (x : BitVec 7),
  ¬3#7 ≥ ↑7 → signExtend 16 (truncate 4 (x >>> 3#7)) = signExtend 16 (x.sshiftRight' 3#7) :=
sorry