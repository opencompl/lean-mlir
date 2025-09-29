
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

theorem shl1_nsw_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  ¬(True ∧ (1#8 <<< x).sshiftRight' x ≠ 1#8 ∨
        x ≥ ↑8 ∨
          True ∧ x_1.smod (1#8 <<< x) ≠ 0 ∨ (1#8 <<< x == 0 || 8 != 1 && x_1 == intMin 8 && 1#8 <<< x == -1) = true) →
    True ∧ x_1 >>> x <<< x ≠ x_1 ∨ x ≥ ↑8 → False :=
sorry