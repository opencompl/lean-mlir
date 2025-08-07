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

theorem squared_nsw_sgt0_thm.extracted_1._1 : ∀ (x : BitVec 5),
  ¬(True ∧ x.smulOverflow x = true) → ofBool (0#5 <ₛ x * x) = ofBool (x != 0#5) :=
sorry