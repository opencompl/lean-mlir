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

theorem pr33078_1_thm.extracted_1._2 : ∀ (x : BitVec 8),
  ¬8#16 ≥ ↑16 → ¬7#8 ≥ ↑8 → truncate 8 (signExtend 16 x >>> 8#16) = x.sshiftRight' 7#8 :=
sorry