
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

theorem bitwise_and_logical_and_masked_icmp_asymmetric_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬ofBool (x &&& 255#32 != 0#32) = 1#1 → ofBool (x &&& 11#32 == 11#32) = 1#1 → False :=
sorry