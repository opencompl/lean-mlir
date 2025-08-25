
/-
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
-/

theorem lowmask_sub_zext_commute_thm.extracted_1._1 : ∀ (x : BitVec 5) (x_1 : BitVec 17),
  x_1 - zeroExtend 17 x &&& 31#17 = zeroExtend 17 (truncate 5 x_1 - x) :=
sorry