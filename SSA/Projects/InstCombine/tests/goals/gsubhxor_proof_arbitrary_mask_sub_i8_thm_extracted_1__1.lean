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

theorem arbitrary_mask_sub_i8_thm.extracted_1._1 : ∀ (x : BitVec 8),
  True ∧ (11#8).ssubOverflow (x &&& 10#8) = true ∨ True ∧ (11#8).usubOverflow (x &&& 10#8) = true →
    HRefinement.IsRefinedBy (β := PoisonOr (BitVec 8)) (self :=
      @instHRefinementOfRefinement _
        (@PoisonOr.instRefinement _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec)))
      (PoisonOr.value (11#8 - (x &&& 10#8))) PoisonOr.poison :=
sorry