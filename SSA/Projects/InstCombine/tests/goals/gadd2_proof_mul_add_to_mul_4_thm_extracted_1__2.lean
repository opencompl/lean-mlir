
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

theorem mul_add_to_mul_4_thm.extracted_1._2 : ∀ (x : BitVec 16),
  ¬(True ∧ x.smulOverflow 2#16 = true ∨
        True ∧ x.smulOverflow 7#16 = true ∨ True ∧ (x * 2#16).saddOverflow (x * 7#16) = true) →
    ¬(True ∧ x.smulOverflow 9#16 = true) → x * 2#16 + x * 7#16 = x * 9#16 :=
sorry