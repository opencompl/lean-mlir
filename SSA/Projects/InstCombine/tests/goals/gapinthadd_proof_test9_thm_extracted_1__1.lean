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

theorem test9_thm.extracted_1._1 : ∀ (x : BitVec 77),
  True ∧ (x &&& 562949953421310#77 &&& 1#77 != 0) = true →
    HRefinement.IsRefinedBy (β := PoisonOr (BitVec 77)) (self :=
      @instHRefinementOfRefinement _
        (@PoisonOr.instRefinement _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec)))
      (PoisonOr.value ((x &&& 562949953421310#77) + 1#77)) PoisonOr.poison :=
sorry