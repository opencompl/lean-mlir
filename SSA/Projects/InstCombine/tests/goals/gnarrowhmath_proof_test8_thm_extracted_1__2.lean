
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

theorem test8_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬16#32 ≥ ↑32 →
    ¬(16#32 ≥ ↑32 ∨ True ∧ (x.sshiftRight' 16#32).smulOverflow 32767#32 = true) →
      signExtend 64 (x.sshiftRight' 16#32) * 32767#64 = signExtend 64 (x.sshiftRight' 16#32 * 32767#32) :=
sorry