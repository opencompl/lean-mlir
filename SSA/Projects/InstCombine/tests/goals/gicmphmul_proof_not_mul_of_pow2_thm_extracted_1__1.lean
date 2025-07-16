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

theorem not_mul_of_pow2_thm.extracted_1._1 : ∀ (x : BitVec 8) (x_1 : BitVec 32),
  True ∧ (x_1 &&& 6#32).smulOverflow (zeroExtend 32 x) = true ∨
      True ∧ (x_1 &&& 6#32).umulOverflow (zeroExtend 32 x) = true →
    HRefinement.IsRefinedBy (β := PoisonOr (BitVec 1)) (self :=
      @instHRefinementOfRefinement _
        (@PoisonOr.instRefinement _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec)))
      (PoisonOr.value (ofBool (1530#32 <ᵤ (x_1 &&& 6#32) * zeroExtend 32 x))) PoisonOr.poison :=
sorry