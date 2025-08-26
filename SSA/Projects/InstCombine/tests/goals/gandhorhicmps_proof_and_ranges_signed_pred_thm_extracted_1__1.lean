
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

theorem and_ranges_signed_pred_thm.extracted_1._1 : ∀ (x : BitVec 64),
  ofBool (x + 127#64 <ₛ 1024#64) &&& ofBool (x + 128#64 <ₛ 256#64) =
    ofBool (x + BitVec.ofInt 64 (-9223372036854775681) <ᵤ BitVec.ofInt 64 (-9223372036854775553)) :=
sorry