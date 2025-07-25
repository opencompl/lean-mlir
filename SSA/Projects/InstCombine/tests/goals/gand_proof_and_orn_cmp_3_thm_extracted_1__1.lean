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

theorem and_orn_cmp_3_thm.extracted_1._1 : ∀ (x x_1 x_2 : BitVec 72),
  ofBool (x_1 <ᵤ x_2) &&& (ofBool (x_2 ≤ᵤ x_1) ||| ofBool (42#72 <ᵤ x)) = ofBool (x_1 <ᵤ x_2) &&& ofBool (42#72 <ᵤ x) :=
sorry