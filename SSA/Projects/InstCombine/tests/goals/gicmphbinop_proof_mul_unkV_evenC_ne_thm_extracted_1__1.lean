
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

theorem mul_unkV_evenC_ne_thm.extracted_1._1 : ∀ (x : BitVec 64),
  ofBool (x * 4#64 != 0#64) = ofBool (x &&& 4611686018427387903#64 != 0#64) :=
sorry