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

theorem t1_thm.extracted_1._1 : ∀ (x : BitVec 32) (x_1 : BitVec 16),
  ¬(x ≥ ↑32 ∨ (2#32 <<< x == 0 || 32 != 1 && zeroExtend 32 x_1 == intMin 32 && 2#32 <<< x == -1) = true) →
    x + 1#32 ≥ ↑32 →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 32)) (self :=
        @instHRefinementOfRefinement _
          (@PoisonOr.instRefinement _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec)))
        (PoisonOr.value ((zeroExtend 32 x_1).sdiv (2#32 <<< x))) PoisonOr.poison :=
sorry