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

theorem p1_ugt_thm.extracted_1._2 : ∀ (x x_1 : BitVec 32),
  ofBool (65534#32 <ᵤ x_1) = 1#1 → ofBool (x_1 <ᵤ 65535#32) = 1#1 → x = 65535#32 :=
sorry