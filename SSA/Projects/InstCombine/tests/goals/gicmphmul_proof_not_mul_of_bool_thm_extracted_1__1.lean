
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

theorem not_mul_of_bool_thm.extracted_1._1 : ∀ (x : BitVec 8) (x_1 : BitVec 32),
  True ∧ (x_1 &&& 3#32).smulOverflow (zeroExtend 32 x) = true ∨
      True ∧ (x_1 &&& 3#32).umulOverflow (zeroExtend 32 x) = true →
    False :=
sorry