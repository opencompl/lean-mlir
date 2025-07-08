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

theorem lowmask_add_zext_commute_thm.extracted_1._1 : ∀ (x : BitVec 16) (x_1 : BitVec 32),
  x_1 * x_1 + zeroExtend 32 x &&& 65535#32 = zeroExtend 32 (x + truncate 16 (x_1 * x_1)) :=
sorry