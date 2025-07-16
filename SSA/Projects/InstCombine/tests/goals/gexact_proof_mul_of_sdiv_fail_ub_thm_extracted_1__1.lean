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

theorem mul_of_sdiv_fail_ub_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬(True ∧ x.smod 6#8 ≠ 0 ∨ (6#8 == 0 || 8 != 1 && x == intMin 8 && 6#8 == -1) = true) →
    x.sdiv 6#8 * BitVec.ofInt 8 (-6) = 0#8 - x :=
sorry