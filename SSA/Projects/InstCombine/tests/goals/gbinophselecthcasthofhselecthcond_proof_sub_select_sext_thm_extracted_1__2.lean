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

theorem sub_select_sext_thm.extracted_1._2 : ∀ (x : BitVec 64) (x_1 : BitVec 1),
  x_1 = 1#1 → 64#64 - signExtend 64 x_1 = 65#64 :=
sorry