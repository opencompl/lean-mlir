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

theorem mul_add_to_mul_9_thm.extracted_1._2 : ∀ (x : BitVec 16),
  ¬(True ∧ x.smulOverflow 16384#16 = true ∨
        True ∧ x.smulOverflow 16384#16 = true ∨ True ∧ (x * 16384#16).saddOverflow (x * 16384#16) = true) →
    ¬15#16 ≥ ↑16 → x * 16384#16 + x * 16384#16 = x <<< 15#16 :=
sorry