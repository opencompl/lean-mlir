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

theorem ashrslt_02_05_thm.extracted_1._1 : ∀ (x : BitVec 4), ¬2#4 ≥ ↑4 → ofBool (x.sshiftRight' 2#4 <ₛ 5#4) = 1#1 :=
sorry