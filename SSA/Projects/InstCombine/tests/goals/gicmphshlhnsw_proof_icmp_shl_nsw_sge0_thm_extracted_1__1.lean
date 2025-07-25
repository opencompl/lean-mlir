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

theorem icmp_shl_nsw_sge0_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬(True ∧ (x <<< 21#32).sshiftRight' 21#32 ≠ x ∨ 21#32 ≥ ↑32) → ofBool (0#32 ≤ₛ x <<< 21#32) = ofBool (-1#32 <ₛ x) :=
sorry