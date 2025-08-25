
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

theorem bitwise_and_logical_and_masked_icmp_allones_thm.extracted_1._4 : ∀ (x : BitVec 1) (x_1 : BitVec 32),
  ofBool (x_1 &&& 8#32 == 8#32) = 1#1 →
    ¬ofBool (x_1 &&& 15#32 == 15#32) = 1#1 → x &&& ofBool (x_1 &&& 7#32 == 7#32) = 0#1 :=
sorry