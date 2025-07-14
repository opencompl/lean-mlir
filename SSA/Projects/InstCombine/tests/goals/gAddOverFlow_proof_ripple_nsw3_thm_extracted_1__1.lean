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

theorem ripple_nsw3_thm.extracted_1._1 : ∀ (x x_1 : BitVec 16),
  True ∧ (x_1 &&& BitVec.ofInt 16 (-21845)).saddOverflow (x &&& 21843#16) = true ∨
      True ∧ (x_1 &&& BitVec.ofInt 16 (-21845)).uaddOverflow (x &&& 21843#16) = true →
    HRefinement.IsRefinedBy (β := PoisonOr (BitVec 16)) (self :=
      @instHRefinementOfRefinement _
        (@PoisonOr.instRefinement _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec)))
      (PoisonOr.value ((x_1 &&& BitVec.ofInt 16 (-21845)) + (x &&& 21843#16))) PoisonOr.poison :=
sorry