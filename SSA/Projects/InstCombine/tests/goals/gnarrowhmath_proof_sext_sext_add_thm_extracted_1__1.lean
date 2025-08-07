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

theorem sext_sext_add_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬(7#32 ≥ ↑32 ∨ 9#32 ≥ ↑32) →
    7#32 ≥ ↑32 ∨ 9#32 ≥ ↑32 ∨ True ∧ (x.sshiftRight' 7#32).saddOverflow (x.sshiftRight' 9#32) = true →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 64)) (self :=
        @instHRefinementOfRefinement _
          (@PoisonOr.instRefinement _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec)))
        (PoisonOr.value (signExtend 64 (x.sshiftRight' 7#32) + signExtend 64 (x.sshiftRight' 9#32))) PoisonOr.poison :=
sorry