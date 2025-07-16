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

theorem positive_biggerashr_shlnuw_ashrexact_thm.extracted_1._2 : ∀ (x : BitVec 8),
  ¬(True ∧ x >>> 6#8 <<< 6#8 ≠ x ∨
        6#8 ≥ ↑8 ∨ True ∧ x.sshiftRight' 6#8 <<< 3#8 >>> 3#8 ≠ x.sshiftRight' 6#8 ∨ 3#8 ≥ ↑8) →
    ¬(True ∧ x >>> 3#8 <<< 3#8 ≠ x ∨ 3#8 ≥ ↑8) → x.sshiftRight' 6#8 <<< 3#8 = x.sshiftRight' 3#8 :=
sorry