
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

theorem sub_from_constant_commute_thm.extracted_1._1 : ∀ (x x_1 : BitVec 5),
  ¬(True ∧ (10#5).ssubOverflow x = true ∨ True ∧ (x_1 * x_1).saddOverflow (10#5 - x) = true) →
    x_1 * x_1 + (10#5 - x) = x_1 * x_1 - x + 10#5 :=
sorry