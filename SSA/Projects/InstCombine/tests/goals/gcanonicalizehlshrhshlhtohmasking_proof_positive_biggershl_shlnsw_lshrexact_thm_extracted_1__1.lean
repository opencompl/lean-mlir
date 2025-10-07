
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

theorem positive_biggershl_shlnsw_lshrexact_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬(True ∧ x >>> 3#8 <<< 3#8 ≠ x ∨ 3#8 ≥ ↑8 ∨ True ∧ (x >>> 3#8 <<< 6#8).sshiftRight' 6#8 ≠ x >>> 3#8 ∨ 6#8 ≥ ↑8) →
    True ∧ (x <<< 3#8).sshiftRight' 3#8 ≠ x ∨ True ∧ x <<< 3#8 >>> 3#8 ≠ x ∨ 3#8 ≥ ↑8 → False :=
sorry