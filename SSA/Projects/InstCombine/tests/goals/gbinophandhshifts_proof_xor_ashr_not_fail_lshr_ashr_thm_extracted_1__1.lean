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

theorem xor_ashr_not_fail_lshr_ashr_thm.extracted_1._1 : ∀ (x x_1 x_2 : BitVec 8),
  ¬(x_1 ≥ ↑8 ∨ x_1 ≥ ↑8) →
    x_2 >>> x_1 ^^^ (x.sshiftRight' x_1 ^^^ -1#8) = x.sshiftRight' x_1 ^^^ x_2 >>> x_1 ^^^ -1#8 :=
sorry