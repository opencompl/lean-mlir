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

theorem scalar_zext_slt_thm.extracted_1._1 : ∀ (x : BitVec 16),
  ofBool (zeroExtend 32 x <ₛ 500#32) = ofBool (x <ᵤ 500#16) :=
sorry