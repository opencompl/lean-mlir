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

theorem andn_or_cmp_2_thm.extracted_1._1 : ∀ (x x_1 x_2 : BitVec 16),
  (ofBool (42#16 <ᵤ x_2) ||| ofBool (x ≤ₛ x_1)) &&& ofBool (x_1 <ₛ x) = ofBool (42#16 <ᵤ x_2) &&& ofBool (x_1 <ₛ x) :=
sorry