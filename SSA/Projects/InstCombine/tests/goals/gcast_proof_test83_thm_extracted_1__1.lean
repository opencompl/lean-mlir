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

theorem test83_thm.extracted_1._1 : ∀ (x : BitVec 64) (x_1 : BitVec 16),
  ¬(True ∧ x.saddOverflow (-1#64) = true ∨ truncate 32 (x + -1#64) ≥ ↑32) →
    truncate 32 x + -1#32 ≥ ↑32 →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 64)) (self :=
        @instHRefinementOfRefinement _
          (@PoisonOr.instRefinement _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec)))
        (PoisonOr.value (zeroExtend 64 (signExtend 32 x_1 <<< truncate 32 (x + -1#64)))) PoisonOr.poison :=
sorry