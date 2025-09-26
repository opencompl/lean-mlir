
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

theorem mul_add_to_mul_6_thm.extracted_1._2 : ∀ (x x_1 : BitVec 32),
  ¬(True ∧ x_1.smulOverflow x = true ∨
        True ∧ x_1.smulOverflow x = true ∨
          True ∧ (x_1 * x).smulOverflow 5#32 = true ∨ True ∧ (x_1 * x).saddOverflow (x_1 * x * 5#32) = true) →
    ¬(True ∧ x_1.smulOverflow x = true ∨ True ∧ (x_1 * x).smulOverflow 6#32 = true) →
      x_1 * x + x_1 * x * 5#32 = x_1 * x * 6#32 :=
sorry