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

theorem shl_sub_lshr_reverse_nsw_on_op1_thm.extracted_1._2 : ∀ (x x_1 x_2 : BitVec 32),
  ¬(True ∧ (x_1 <<< x).sshiftRight' x ≠ x_1 ∨
        True ∧ x_1 <<< x >>> x ≠ x_1 ∨
          x ≥ ↑32 ∨
            True ∧ x_2.usubOverflow (x_1 <<< x) = true ∨
              True ∧ (x_2 - x_1 <<< x) >>> x <<< x ≠ x_2 - x_1 <<< x ∨ x ≥ ↑32) →
    ¬(True ∧ x_2 >>> x <<< x ≠ x_2 ∨ x ≥ ↑32 ∨ True ∧ (x_2 >>> x).usubOverflow x_1 = true) →
      (x_2 - x_1 <<< x) >>> x = x_2 >>> x - x_1 :=
sorry