
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

theorem t1_flags_thm.extracted_1._1 : ∀ (x x_1 x_2 : BitVec 8),
  ¬(True ∧ x_2.ssubOverflow x_1 = true ∨
        True ∧ x_2.usubOverflow x_1 = true ∨
          True ∧ (x_2 - x_1).ssubOverflow x = true ∨ True ∧ (x_2 - x_1).usubOverflow x = true) →
    True ∧ x_1.saddOverflow x = true ∨
        True ∧ x_1.uaddOverflow x = true ∨
          True ∧ x_2.ssubOverflow (x_1 + x) = true ∨ True ∧ x_2.usubOverflow (x_1 + x) = true →
      False :=
sorry