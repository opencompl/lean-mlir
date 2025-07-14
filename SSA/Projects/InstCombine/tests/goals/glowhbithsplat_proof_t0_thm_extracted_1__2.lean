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

theorem t0_thm.extracted_1._2 : ∀ (x : BitVec 8),
  ¬(7#8 ≥ ↑8 ∨ 7#8 ≥ ↑8) →
    ¬(True ∧ (0#8).ssubOverflow (x &&& 1#8) = true) → (x <<< 7#8).sshiftRight' 7#8 = 0#8 - (x &&& 1#8) :=
sorry