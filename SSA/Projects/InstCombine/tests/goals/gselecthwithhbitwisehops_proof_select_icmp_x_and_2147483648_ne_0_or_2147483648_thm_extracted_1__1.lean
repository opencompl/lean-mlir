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

theorem select_icmp_x_and_2147483648_ne_0_or_2147483648_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬ofBool (x &&& BitVec.ofInt 32 (-2147483648) == 0#32) = 1#1 → x = x ||| BitVec.ofInt 32 (-2147483648) :=
sorry