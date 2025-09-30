
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

theorem foo_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ¬(True ∧ x_1.saddOverflow x = true ∨ True ∧ (x_1 + x).smulOverflow x_1 = true ∨ True ∧ x_1.smulOverflow x_1 = true) →
    (x_1 + x) * x_1 - x_1 * x_1 = x * x_1 :=
sorry