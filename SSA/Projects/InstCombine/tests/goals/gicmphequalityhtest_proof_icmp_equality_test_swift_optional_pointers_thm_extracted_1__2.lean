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

theorem icmp_equality_test_swift_optional_pointers_thm.extracted_1._2 : ∀ (x x_1 : BitVec 64),
  ofBool (x_1 == 0#64) = 1#1 → ¬True → ofBool (x == 0#64) = ofBool (x_1 == x) :=
sorry