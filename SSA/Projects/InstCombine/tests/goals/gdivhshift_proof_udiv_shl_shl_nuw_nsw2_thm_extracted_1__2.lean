
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

theorem udiv_shl_shl_nuw_nsw2_thm.extracted_1._2 : ∀ (x x_1 x_2 : BitVec 8),
  ¬(True ∧ (x_2 <<< x_1).sshiftRight' x_1 ≠ x_2 ∨
        True ∧ x_2 <<< x_1 >>> x_1 ≠ x_2 ∨
          x_1 ≥ ↑8 ∨ True ∧ (x <<< x_1).sshiftRight' x_1 ≠ x ∨ x_1 ≥ ↑8 ∨ x <<< x_1 = 0) →
    ¬x = 0 → x_2 <<< x_1 / x <<< x_1 = x_2 / x :=
sorry