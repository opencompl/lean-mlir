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

theorem ashrsgt_03_14_thm.extracted_1._1 : ∀ (x : BitVec 4),
  ¬3#4 ≥ ↑4 → ofBool (BitVec.ofInt 4 (-2) <ₛ x.sshiftRight' 3#4) = 1#1 :=
sorry