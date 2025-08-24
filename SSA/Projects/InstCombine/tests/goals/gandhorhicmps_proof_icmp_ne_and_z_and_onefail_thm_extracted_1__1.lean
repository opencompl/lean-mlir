
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

theorem icmp_ne_and_z_and_onefail_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ofBool (x != 0#8) &&& ofBool (x != 1#8) &&& ofBool (x != 2#8) = ofBool (2#8 <ᵤ x) :=
sorry