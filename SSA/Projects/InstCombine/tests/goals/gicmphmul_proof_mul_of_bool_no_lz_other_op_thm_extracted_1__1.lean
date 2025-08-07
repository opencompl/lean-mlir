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

theorem mul_of_bool_no_lz_other_op_thm.extracted_1._1 : ∀ (x : BitVec 8) (x_1 : BitVec 32),
  ¬(True ∧ (x_1 &&& 1#32).smulOverflow (signExtend 32 x) = true ∨
        True ∧ (x_1 &&& 1#32).umulOverflow (signExtend 32 x) = true) →
    ofBool (127#32 <ₛ (x_1 &&& 1#32) * signExtend 32 x) = 0#1 :=
sorry