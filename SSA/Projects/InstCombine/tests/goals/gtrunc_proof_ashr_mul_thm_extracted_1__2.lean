
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

theorem ashr_mul_thm.extracted_1._2 : ∀ (x x_1 : BitVec 8),
  ¬8#20 ≥ ↑20 →
    ¬(True ∧ (signExtend 16 x_1).smulOverflow (signExtend 16 x) = true ∨ 8#16 ≥ ↑16) →
      truncate 16 ((signExtend 20 x_1 * signExtend 20 x).sshiftRight' 8#20) =
        (signExtend 16 x_1 * signExtend 16 x).sshiftRight' 8#16 :=
sorry