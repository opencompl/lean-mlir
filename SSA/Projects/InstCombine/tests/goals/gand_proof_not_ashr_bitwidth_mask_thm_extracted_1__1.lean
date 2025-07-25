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

theorem not_ashr_bitwidth_mask_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  ¬7#8 ≥ ↑8 → ofBool (x_1 <ₛ 0#8) = 1#1 → (x_1.sshiftRight' 7#8 ^^^ -1#8) &&& x = 0#8 :=
sorry