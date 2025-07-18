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

theorem positive_with_extra_and_logical_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬(ofBool (x + 128#32 <ᵤ 256#32) = 1#1 ∧ ofBool (-1#32 <ₛ x) = 1#1) →
    ofBool (x <ᵤ 128#32) = 1#1 →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 1)) (self :=
        @instHRefinementOfRefinement _
          (@PoisonOr.instRefinement _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec)))
        (PoisonOr.value 0#1) PoisonOr.poison :=
sorry