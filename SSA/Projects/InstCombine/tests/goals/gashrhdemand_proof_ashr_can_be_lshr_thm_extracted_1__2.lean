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

theorem ashr_can_be_lshr_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬(True ∧ x >>> 16#32 <<< 16#32 ≠ x ∨
        16#32 ≥ ↑32 ∨ True ∧ signExtend 32 (truncate 16 (x.sshiftRight' 16#32)) ≠ x.sshiftRight' 16#32) →
    ¬(True ∧ x >>> 16#32 <<< 16#32 ≠ x ∨ 16#32 ≥ ↑32 ∨ True ∧ zeroExtend 32 (truncate 16 (x >>> 16#32)) ≠ x >>> 16#32) →
      truncate 16 (x.sshiftRight' 16#32) = truncate 16 (x >>> 16#32) :=
sorry