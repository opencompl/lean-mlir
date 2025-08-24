
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

theorem sext_sext_add_mismatched_types_thm.extracted_1._1 : ∀ (x : BitVec 32) (x_1 : BitVec 16),
  ¬(7#16 ≥ ↑16 ∨ 9#32 ≥ ↑32) →
    7#16 ≥ ↑16 ∨
        9#32 ≥ ↑32 ∨
          True ∧ (signExtend 64 (x_1.sshiftRight' 7#16)).saddOverflow (signExtend 64 (x.sshiftRight' 9#32)) = true →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 64)) (self :=
        @instHRefinementOfRefinement _
          (@PoisonOr.instRefinement _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec)))
        (PoisonOr.value (signExtend 64 (x_1.sshiftRight' 7#16) + signExtend 64 (x.sshiftRight' 9#32)))
        PoisonOr.poison :=
sorry