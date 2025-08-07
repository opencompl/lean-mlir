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

theorem sub_zext_trunc_lshr_thm.extracted_1._2 : ∀ (x : BitVec 64),
  ¬15#64 ≥ ↑64 →
    ¬(16#32 ≥ ↑32 ∨ 31#32 ≥ ↑32 ∨ True ∧ ((truncate 32 x <<< 16#32).sshiftRight' 31#32).saddOverflow 10#32 = true) →
      10#32 - zeroExtend 32 (truncate 1 (x >>> 15#64)) = (truncate 32 x <<< 16#32).sshiftRight' 31#32 + 10#32 :=
sorry