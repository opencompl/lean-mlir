
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
import SSA.Projects.InstCombine.TacticAuto
import LeanMLIR.Dialects.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000
set_option Elab.async false
-/

theorem test_negative_nsw_and_unsigned_pred_thm.extracted_1._1 : ∀ (x : BitVec 64),
  ¬(True ∧ (10#64).ssubOverflow x = true) → ofBool (10#64 - x <ᵤ 3#64) = ofBool (x + BitVec.ofInt 64 (-8) <ᵤ 3#64) :=
sorry