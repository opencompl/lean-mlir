
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

theorem test43_thm.extracted_1._1 : ∀ (x : BitVec 8),
  True ∧ (zeroExtend 32 x).saddOverflow (-1#32) = true →
    HRefinement.IsRefinedBy (β := PoisonOr (BitVec 64)) (self :=
      @instHRefinementOfRefinement _
        (@PoisonOr.instRefinement _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec)))
      (PoisonOr.value (signExtend 64 (zeroExtend 32 x + -1#32))) PoisonOr.poison :=
sorry