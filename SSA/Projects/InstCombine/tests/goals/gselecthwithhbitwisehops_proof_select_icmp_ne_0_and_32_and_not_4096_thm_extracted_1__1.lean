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

theorem select_icmp_ne_0_and_32_and_not_4096_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ofBool (0#32 != x_1 &&& 32#32) = 1#1 → ofBool (x_1 &&& 32#32 == 0#32) = 1#1 → x = x &&& BitVec.ofInt 32 (-4097) :=
sorry