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

theorem t3_ult_sgt_neg1_thm.extracted_1._4 : ∀ (x x_1 : BitVec 32),
  ¬ofBool (x_1 + 16#32 <ᵤ 144#32) = 1#1 →
    ofBool (BitVec.ofInt 32 (-17) <ₛ x_1) = 1#1 →
      ¬ofBool (127#32 <ₛ x_1) = 1#1 →
        ofBool (x_1 <ₛ BitVec.ofInt 32 (-16)) = 1#1 →
          HRefinement.IsRefinedBy (β := PoisonOr (BitVec 32)) (self :=
            @instHRefinementOfRefinement _
              (@PoisonOr.instRefinement _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec)))
            (PoisonOr.value x) PoisonOr.poison :=
sorry