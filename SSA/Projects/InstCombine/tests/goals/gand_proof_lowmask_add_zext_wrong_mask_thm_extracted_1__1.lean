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

theorem lowmask_add_zext_wrong_mask_thm.extracted_1._1 : ∀ (x : BitVec 32) (x_1 : BitVec 8),
  zeroExtend 32 x_1 + x &&& 511#32 = x + zeroExtend 32 x_1 &&& 511#32 :=
sorry