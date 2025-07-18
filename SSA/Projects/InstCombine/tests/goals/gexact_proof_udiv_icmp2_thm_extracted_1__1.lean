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

theorem udiv_icmp2_thm.extracted_1._1 : ∀ (x : BitVec 64),
  ¬(True ∧ x.umod 5#64 ≠ 0 ∨ 5#64 = 0) → ofBool (x / 5#64 == 0#64) = ofBool (x == 0#64) :=
sorry