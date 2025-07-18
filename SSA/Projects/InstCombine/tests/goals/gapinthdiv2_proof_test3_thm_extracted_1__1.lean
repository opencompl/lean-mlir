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

theorem test3_thm.extracted_1._1 : ∀ (x : BitVec 1) (x_1 : BitVec 599),
  x = 1#1 →
    ¬70368744177664#599 = 0 →
      46#599 ≥ ↑599 →
        HRefinement.IsRefinedBy (β := PoisonOr (BitVec 599)) (self :=
          @instHRefinementOfRefinement _
            (@PoisonOr.instRefinement _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec)))
          (PoisonOr.value (x_1 / 70368744177664#599)) PoisonOr.poison :=
sorry