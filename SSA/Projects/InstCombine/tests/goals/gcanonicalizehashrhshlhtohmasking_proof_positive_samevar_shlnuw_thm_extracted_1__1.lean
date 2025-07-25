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

theorem positive_samevar_shlnuw_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  ¬(x ≥ ↑8 ∨ True ∧ x_1.sshiftRight' x <<< x >>> x ≠ x_1.sshiftRight' x ∨ x ≥ ↑8) →
    True ∧ ((-1#8) <<< x).sshiftRight' x ≠ -1#8 ∨ x ≥ ↑8 →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 8)) (self :=
        @instHRefinementOfRefinement _
          (@PoisonOr.instRefinement _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec)))
        (PoisonOr.value (x_1.sshiftRight' x <<< x)) PoisonOr.poison :=
sorry