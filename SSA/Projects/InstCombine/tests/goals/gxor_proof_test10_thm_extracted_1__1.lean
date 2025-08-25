
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

theorem test10_thm.extracted_1._1 : ∀ (x : BitVec 8),
  True ∧ (x &&& 3#8 &&& 4#8 != 0) = true →
    HRefinement.IsRefinedBy (β := PoisonOr (BitVec 8)) (self :=
      @instHRefinementOfRefinement _
        (@PoisonOr.instRefinement _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec)))
      (PoisonOr.value (x &&& 3#8 ^^^ 4#8)) PoisonOr.poison :=
sorry