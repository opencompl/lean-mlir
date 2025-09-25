
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

theorem positive_samevar_thm.extracted_1._2 : ∀ (x x_1 : BitVec 8),
  ¬(x ≥ ↑8 ∨ x ≥ ↑8) →
    ¬(True ∧ ((-1#8) <<< x).sshiftRight' x ≠ -1#8 ∨ x ≥ ↑8) → x_1.sshiftRight' x <<< x = (-1#8) <<< x &&& x_1 :=
sorry