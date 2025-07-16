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

theorem add_nuw_nsw_or_and_thm.extracted_1._2 : ∀ (x x_1 : BitVec 32),
  ¬(True ∧ (x_1 ||| x).saddOverflow (x_1 &&& x) = true ∨ True ∧ (x_1 ||| x).uaddOverflow (x_1 &&& x) = true) →
    ¬(True ∧ x_1.saddOverflow x = true ∨ True ∧ x_1.uaddOverflow x = true) → (x_1 ||| x) + (x_1 &&& x) = x_1 + x :=
sorry