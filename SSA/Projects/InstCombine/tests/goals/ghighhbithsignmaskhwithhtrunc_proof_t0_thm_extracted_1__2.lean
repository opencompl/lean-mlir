
/-
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
-/

theorem t0_thm.extracted_1._2 : ∀ (x : BitVec 64),
  ¬63#64 ≥ ↑64 →
    ¬(63#64 ≥ ↑64 ∨ True ∧ signExtend 64 (truncate 32 (x.sshiftRight' 63#64)) ≠ x.sshiftRight' 63#64) →
      0#32 - truncate 32 (x >>> 63#64) = truncate 32 (x.sshiftRight' 63#64) :=
sorry