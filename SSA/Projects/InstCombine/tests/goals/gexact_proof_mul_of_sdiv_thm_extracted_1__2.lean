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

theorem mul_of_sdiv_thm.extracted_1._2 : ∀ (x : BitVec 8),
  ¬(True ∧ x.smod 12#8 ≠ 0 ∨ (12#8 == 0 || 8 != 1 && x == intMin 8 && 12#8 == -1) = true) →
    ¬(True ∧ x >>> 1#8 <<< 1#8 ≠ x ∨ 1#8 ≥ ↑8 ∨ True ∧ (0#8).ssubOverflow (x.sshiftRight' 1#8) = true) →
      x.sdiv 12#8 * BitVec.ofInt 8 (-6) = 0#8 - x.sshiftRight' 1#8 :=
sorry