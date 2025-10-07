
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

theorem mul_add_to_mul_2_thm.extracted_1._2 : ∀ (x : BitVec 16),
  ¬(True ∧ x.smulOverflow 8#16 = true ∨ True ∧ (x * 8#16).saddOverflow x = true) →
    ¬(True ∧ x.smulOverflow 9#16 = true) → x * 8#16 + x = x * 9#16 :=
sorry