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

theorem select_icmp_ne_0_and_1073741824_xor_8_thm.extracted_1._2 : ∀ (x : BitVec 8) (x_1 : BitVec 32),
  ¬ofBool (0#32 != x_1 &&& 1073741824#32) = 1#1 → ¬ofBool (x_1 &&& 1073741824#32 == 0#32) = 1#1 → x ^^^ 8#8 = x :=
sorry