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

theorem logical_and_logical_and_icmps_comm1_thm.extracted_1._4 : ∀ (x x_1 x_2 : BitVec 8),
  ¬x_1 ≥ ↑8 →
    ofBool (x_2 &&& 1#8 <<< x_1 != 0#8) = 1#1 ∧ ofBool (x == 42#8) = 1#1 →
      True ∧ 1#8 <<< x_1 >>> x_1 ≠ 1#8 ∨ x_1 ≥ ↑8 →
        HRefinement.IsRefinedBy (β := PoisonOr (BitVec 1)) (self :=
          @instHRefinementOfRefinement _
            (@PoisonOr.instRefinement _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec)))
          (PoisonOr.value (ofBool (x_2 &&& 1#8 != 0#8))) PoisonOr.poison :=
sorry