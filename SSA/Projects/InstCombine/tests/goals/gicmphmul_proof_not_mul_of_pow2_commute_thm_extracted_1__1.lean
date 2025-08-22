
/-
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
-/

theorem not_mul_of_pow2_commute_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  True ∧ (x_1 &&& 255#32).smulOverflow (x &&& 12#32) = true ∨
      True ∧ (x_1 &&& 255#32).umulOverflow (x &&& 12#32) = true →
    HRefinement.IsRefinedBy (β := PoisonOr (BitVec 1)) (self :=
      @instHRefinementOfRefinement _
        (@PoisonOr.instRefinement _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec)))
      (PoisonOr.value (ofBool (3060#32 <ᵤ (x_1 &&& 255#32) * (x &&& 12#32)))) PoisonOr.poison :=
sorry