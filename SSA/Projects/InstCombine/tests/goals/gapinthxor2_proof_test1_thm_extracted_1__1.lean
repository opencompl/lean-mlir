
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

theorem test1_thm.extracted_1._1 : ∀ (x x_1 : BitVec 447),
  True ∧ (x_1 &&& 70368744177664#447 &&& (x &&& 70368744177663#447) != 0) = true →
    HRefinement.IsRefinedBy (β := PoisonOr (BitVec 447)) (self :=
      @instHRefinementOfRefinement _
        (@PoisonOr.instRefinement _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec)))
      (PoisonOr.value (x_1 &&& 70368744177664#447 ^^^ x &&& 70368744177663#447)) PoisonOr.poison :=
sorry