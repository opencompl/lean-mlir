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

theorem test4_thm.extracted_1._1 : ∀ (x x_1 : BitVec 9),
  True ∧ (zeroExtend 64 x_1).saddOverflow (zeroExtend 64 x) = true ∨
      True ∧ (zeroExtend 64 x_1).uaddOverflow (zeroExtend 64 x) = true →
    HRefinement.IsRefinedBy (β := PoisonOr (BitVec 9)) (self :=
      @instHRefinementOfRefinement _
        (@PoisonOr.instRefinement _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec)))
      (PoisonOr.value (truncate 9 (zeroExtend 64 x_1 + zeroExtend 64 x))) PoisonOr.poison :=
sorry