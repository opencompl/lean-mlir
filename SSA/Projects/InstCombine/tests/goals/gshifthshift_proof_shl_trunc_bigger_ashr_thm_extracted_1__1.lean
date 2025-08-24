
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

theorem shl_trunc_bigger_ashr_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬(12#32 ≥ ↑32 ∨ 3#24 ≥ ↑24) →
    9#32 ≥ ↑32 ∨ True ∧ signExtend 32 (truncate 24 (x.sshiftRight' 9#32)) ≠ x.sshiftRight' 9#32 →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 24)) (self :=
        @instHRefinementOfRefinement _
          (@PoisonOr.instRefinement _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec)))
        (PoisonOr.value (truncate 24 (x.sshiftRight' 12#32) <<< 3#24)) PoisonOr.poison :=
sorry