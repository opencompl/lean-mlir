
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

theorem test3_thm.extracted_1._2 : ∀ (x x_1 : BitVec 32),
  ¬(True ∧ x_1.ssubOverflow x = true ∨ True ∧ x_1.ssubOverflow x = true) →
    ¬(True ∧ x_1.ssubOverflow x = true) →
      ofBool (x_1 - x == 0#32) ||| ofBool (x_1 - x == 31#32) = ofBool (x_1 == x) ||| ofBool (x_1 - x == 31#32) :=
sorry