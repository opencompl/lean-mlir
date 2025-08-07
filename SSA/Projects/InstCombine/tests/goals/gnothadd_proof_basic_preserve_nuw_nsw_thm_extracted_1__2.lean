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

theorem basic_preserve_nuw_nsw_thm.extracted_1._2 : ∀ (x x_1 : BitVec 8),
  ¬(True ∧ (x_1 ^^^ -1#8).saddOverflow x = true ∨ True ∧ (x_1 ^^^ -1#8).uaddOverflow x = true) →
    ¬(True ∧ x_1.ssubOverflow x = true ∨ True ∧ x_1.usubOverflow x = true) → (x_1 ^^^ -1#8) + x ^^^ -1#8 = x_1 - x :=
sorry