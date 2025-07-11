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

theorem f_t15_t01_t09_thm.extracted_1._2 : ∀ (x : BitVec 40),
  ¬(31#40 ≥ ↑40 ∨ 16#32 ≥ ↑32) →
    ¬(15#40 ≥ ↑40 ∨ True ∧ signExtend 40 (truncate 32 (x.sshiftRight' 15#40)) ≠ x.sshiftRight' 15#40) →
      truncate 32 (x.sshiftRight' 31#40) <<< 16#32 = truncate 32 (x.sshiftRight' 15#40) &&& BitVec.ofInt 32 (-65536) :=
sorry