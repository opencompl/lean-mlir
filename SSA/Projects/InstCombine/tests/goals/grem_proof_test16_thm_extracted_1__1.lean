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

theorem test16_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ¬(11#32 ≥ ↑32 ∨ (x >>> 11#32 &&& 4#32) + 4#32 = 0) →
    11#32 ≥ ↑32 ∨ True ∧ (x >>> 11#32 &&& 4#32 &&& 3#32 != 0) = true →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 32)) (self :=
        @instHRefinementOfRefinement _
          (@PoisonOr.instRefinement _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec)))
        (PoisonOr.value (x_1 % ((x >>> 11#32 &&& 4#32) + 4#32))) PoisonOr.poison :=
sorry