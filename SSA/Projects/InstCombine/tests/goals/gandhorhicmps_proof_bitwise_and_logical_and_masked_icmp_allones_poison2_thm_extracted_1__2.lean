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

theorem bitwise_and_logical_and_masked_icmp_allones_poison2_thm.extracted_1._2 : ∀ (x : BitVec 32) (x_1 : BitVec 1)
  (x_2 : BitVec 32),
  ofBool (x_2 &&& 8#32 == 8#32) = 1#1 →
    ¬ofBool (x_2 &&& 8#32 != 0#32) = 1#1 → x_1 &&& ofBool (x_2 &&& x == x) = 0#1 &&& ofBool (x_2 &&& x == x) :=
sorry