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

theorem t7_thm.extracted_1._1 : ∀ (x : BitVec 1) (x_1 : BitVec 8), x = 1#1 → x_1 - 0#8 = 0#8 + x_1 :=
sorry