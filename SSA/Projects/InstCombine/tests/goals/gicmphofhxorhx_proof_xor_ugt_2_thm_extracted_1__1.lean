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

theorem xor_ugt_2_thm.extracted_1._1 : ∀ (x x_1 x_2 : BitVec 8),
  True ∧ (x &&& 63#8 &&& 64#8 != 0) = true →
    HRefinement.IsRefinedBy (β := PoisonOr (BitVec 1)) (self :=
      @instHRefinementOfRefinement _
        (@PoisonOr.instRefinement _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec)))
      (PoisonOr.value (ofBool (x_2 + x_1 ^^^ (x &&& 63#8 ||| 64#8) <ᵤ x_2 + x_1))) PoisonOr.poison :=
sorry