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

theorem n12_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬(6#8 ≥ ↑8 ∨ 6#8 ≥ ↑8) →
    6#8 ≥ ↑8 ∨ True ∧ x <<< 6#8 >>> 6#8 <<< 6#8 ≠ x <<< 6#8 ∨ 6#8 ≥ ↑8 →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 8)) (self :=
        @instHRefinementOfRefinement _
          (@PoisonOr.instRefinement _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec)))
        (PoisonOr.value ((x <<< 6#8).sshiftRight' 6#8)) PoisonOr.poison :=
sorry