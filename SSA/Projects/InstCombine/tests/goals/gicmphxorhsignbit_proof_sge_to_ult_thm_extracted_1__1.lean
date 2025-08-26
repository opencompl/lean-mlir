
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

theorem sge_to_ult_thm.extracted_1._1 : ∀ (x : BitVec 8), ofBool (15#8 ≤ₛ x ^^^ 127#8) = ofBool (x <ᵤ 113#8) :=
sorry