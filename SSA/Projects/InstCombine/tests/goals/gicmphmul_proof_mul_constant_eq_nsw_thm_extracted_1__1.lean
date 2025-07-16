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

theorem mul_constant_eq_nsw_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ¬(True ∧ x_1.smulOverflow 6#32 = true ∨ True ∧ x.smulOverflow 6#32 = true) →
    ofBool (x_1 * 6#32 == x * 6#32) = ofBool (x_1 == x) :=
sorry