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

theorem PR30273_three_bools_thm.extracted_1._11 : ∀ (x x_1 x_2 : BitVec 1),
  ¬x_2 = 1#1 →
    ¬x_1 = 1#1 →
      True ∧ (zeroExtend 32 x).saddOverflow (zeroExtend 32 x_2) = true ∨
          True ∧ (zeroExtend 32 x).uaddOverflow (zeroExtend 32 x_2) = true →
        HRefinement.IsRefinedBy (β := PoisonOr (BitVec 32)) (self :=
          @instHRefinementOfRefinement _
            (@PoisonOr.instRefinement _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec)))
          (PoisonOr.value (zeroExtend 32 x)) PoisonOr.poison :=
sorry