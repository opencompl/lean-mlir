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

theorem icmp_select_var_commuted_thm.extracted_1._2 : ∀ (x x_1 x_2 : BitVec 8),
  ¬x_2 = 0 → ofBool (x_1 == 0#8) = 1#1 → ofBool (42#8 / x_2 == 42#8 / x_2) = 1#1 :=
sorry