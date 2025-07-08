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

theorem icmp_select_var_select_thm.extracted_1._17 : ∀ (x x_1 : BitVec 8) (x_2 : BitVec 1),
  ¬x_2 = 1#1 → ¬(ofBool (x_1 == 0#8) = 1#1 ∧ x_2 = 1#1) → ofBool (x_1 == 0#8) = 1#1 → ¬True → ofBool (x == x) = 1#1 :=
sorry