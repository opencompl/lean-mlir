
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

theorem mul_of_pow2_commute_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ofBool (1020#32 <ᵤ (x_1 &&& 255#32) * (x &&& 4#32)) = 0#1 :=
sorry