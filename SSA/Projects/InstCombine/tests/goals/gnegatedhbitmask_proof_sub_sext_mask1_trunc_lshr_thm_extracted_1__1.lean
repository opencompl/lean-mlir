
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

theorem sub_sext_mask1_trunc_lshr_thm.extracted_1._1 : ∀ (x : BitVec 64),
  ¬15#64 ≥ ↑64 →
    48#64 ≥ ↑64 ∨
        63#64 ≥ ↑64 ∨
          True ∧ signExtend 64 (truncate 8 ((x <<< 48#64).sshiftRight' 63#64)) ≠ (x <<< 48#64).sshiftRight' 63#64 ∨
            True ∧ (truncate 8 ((x <<< 48#64).sshiftRight' 63#64)).saddOverflow 10#8 = true →
      False :=
sorry