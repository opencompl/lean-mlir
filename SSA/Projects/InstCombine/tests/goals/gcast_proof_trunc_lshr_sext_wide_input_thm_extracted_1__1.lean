
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

theorem trunc_lshr_sext_wide_input_thm.extracted_1._1 : ∀ (x : BitVec 16),
  ¬9#32 ≥ ↑32 →
    9#16 ≥ ↑16 ∨ True ∧ signExtend 16 (truncate 8 (x.sshiftRight' 9#16)) ≠ x.sshiftRight' 9#16 →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 8)) (self :=
        @instHRefinementOfRefinement _
          (@PoisonOr.instRefinement _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec)))
        (PoisonOr.value (truncate 8 (signExtend 32 x >>> 9#32))) PoisonOr.poison :=
sorry