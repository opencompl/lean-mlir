
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

theorem test_nsw_and_signed_pred_thm.extracted_1._1 : ∀ (x : BitVec 64),
  ¬(True ∧ (3#64).ssubOverflow x = true) → ofBool (10#64 <ₛ 3#64 - x) = ofBool (x <ₛ BitVec.ofInt 64 (-7)) :=
sorry