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

theorem sdiv_shl_shl_nsw2_nuw_thm.extracted_1._2 : ∀ (x x_1 x_2 : BitVec 8),
  ¬(True ∧ (x_2 <<< x_1).sshiftRight' x_1 ≠ x_2 ∨
        x_1 ≥ ↑8 ∨
          True ∧ (x <<< x_1).sshiftRight' x_1 ≠ x ∨
            True ∧ x <<< x_1 >>> x_1 ≠ x ∨
              x_1 ≥ ↑8 ∨ (x <<< x_1 == 0 || 8 != 1 && x_2 <<< x_1 == intMin 8 && x <<< x_1 == -1) = true) →
    ¬(x == 0 || 8 != 1 && x_2 == intMin 8 && x == -1) = true → (x_2 <<< x_1).sdiv (x <<< x_1) = x_2.sdiv x :=
sorry