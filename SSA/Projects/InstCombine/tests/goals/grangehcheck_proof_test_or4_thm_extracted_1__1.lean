
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

theorem test_or4_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ofBool (x_1 &&& 2147483647#32 <ₛ x) ||| ofBool (x <ₛ 0#32) = ofBool (x_1 &&& 2147483647#32 <ᵤ x) :=
sorry