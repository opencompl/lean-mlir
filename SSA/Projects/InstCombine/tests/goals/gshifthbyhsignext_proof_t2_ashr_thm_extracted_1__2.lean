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

theorem t2_ashr_thm.extracted_1._2 : ∀ (x : BitVec 8) (x_1 : BitVec 32),
  ¬signExtend 32 x ≥ ↑32 →
    ¬(True ∧ x.msb = true ∨ zeroExtend 32 x ≥ ↑32) →
      x_1.sshiftRight' (signExtend 32 x) = x_1.sshiftRight' (zeroExtend 32 x) :=
sorry