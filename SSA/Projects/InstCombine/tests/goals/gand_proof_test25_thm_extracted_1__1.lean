
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

theorem test25_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (50#32 ≤ₛ x) &&& ofBool (x <ₛ 100#32) = ofBool (x + BitVec.ofInt 32 (-50) <ᵤ 50#32) :=
sorry