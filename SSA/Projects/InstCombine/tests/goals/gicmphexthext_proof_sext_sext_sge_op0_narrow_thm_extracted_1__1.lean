
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
import SSA.Projects.InstCombine.TacticAuto
import LeanMLIR.Dialects.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000
set_option Elab.async false
-/

theorem sext_sext_sge_op0_narrow_thm.extracted_1._1 : ∀ (x : BitVec 8) (x_1 : BitVec 5),
  ofBool (signExtend 32 x ≤ₛ signExtend 32 x_1) = ofBool (x ≤ₛ signExtend 8 x_1) :=
sorry