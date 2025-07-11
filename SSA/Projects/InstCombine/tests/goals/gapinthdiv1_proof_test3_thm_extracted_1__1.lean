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

theorem test3_thm.extracted_1._1 : ∀ (x : BitVec 1) (x_1 : BitVec 59),
  x = 1#1 →
    ¬1024#59 = 0 →
      10#59 ≥ ↑59 →
        HRefinement.IsRefinedBy (β := PoisonOr (BitVec 59)) (self :=
          @instHRefinementOfRefinement _
            (@PoisonOr.instRefinement _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec)))
          (PoisonOr.value (x_1 / 1024#59)) PoisonOr.poison :=
sorry