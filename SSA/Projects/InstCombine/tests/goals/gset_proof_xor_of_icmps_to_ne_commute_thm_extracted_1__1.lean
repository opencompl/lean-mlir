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

theorem xor_of_icmps_to_ne_commute_thm.extracted_1._1 : ∀ (x : BitVec 64),
  ofBool (x <ₛ 6#64) ^^^ ofBool (4#64 <ₛ x) = ofBool (x != 5#64) :=
sorry