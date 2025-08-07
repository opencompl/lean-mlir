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

theorem shl_nsw_nuw_ult_Csle0_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  ¬(True ∧ (x_1 <<< x).sshiftRight' x ≠ x_1 ∨ True ∧ x_1 <<< x >>> x ≠ x_1 ∨ x ≥ ↑8) →
    ofBool (x_1 <<< x <ᵤ BitVec.ofInt 8 (-19)) = ofBool (x_1 <ᵤ BitVec.ofInt 8 (-19)) :=
sorry