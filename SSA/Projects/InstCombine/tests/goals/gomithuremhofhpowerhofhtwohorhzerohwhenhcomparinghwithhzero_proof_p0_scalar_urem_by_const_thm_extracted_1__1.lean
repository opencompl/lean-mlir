
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

theorem p0_scalar_urem_by_const_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬6#32 = 0 → ofBool ((x &&& 128#32) % 6#32 == 0#32) = ofBool (x &&& 128#32 == 0#32) :=
sorry