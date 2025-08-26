
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

theorem select_icmp_ne_0_and_8_xor_1073741824_thm.extracted_1._1 : ∀ (x : BitVec 32) (x_1 : BitVec 8),
  ofBool (0#8 != x_1 &&& 8#8) = 1#1 → ofBool (x_1 &&& 8#8 == 0#8) = 1#1 → x = x ^^^ 1073741824#32 :=
sorry