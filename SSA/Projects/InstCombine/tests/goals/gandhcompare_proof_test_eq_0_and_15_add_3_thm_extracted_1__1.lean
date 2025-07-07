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

theorem test_eq_0_and_15_add_3_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ofBool (x + 3#8 &&& 15#8 == 0#8) = ofBool (x &&& 15#8 == 13#8) :=
sorry