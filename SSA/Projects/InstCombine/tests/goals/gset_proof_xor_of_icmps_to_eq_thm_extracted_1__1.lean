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

theorem xor_of_icmps_to_eq_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ofBool (x <ₛ BitVec.ofInt 8 (-128)) ^^^ ofBool (126#8 <ₛ x) = ofBool (x == 127#8) :=
sorry