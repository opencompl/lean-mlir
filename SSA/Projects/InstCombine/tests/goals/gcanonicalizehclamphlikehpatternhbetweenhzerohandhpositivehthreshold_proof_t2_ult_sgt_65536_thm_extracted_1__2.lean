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

theorem t2_ult_sgt_65536_thm.extracted_1._2 : ∀ (x x_1 : BitVec 32),
  ofBool (x_1 <ᵤ 65536#32) = 1#1 → ofBool (65535#32 <ₛ x_1) = 1#1 → x_1 = x :=
sorry