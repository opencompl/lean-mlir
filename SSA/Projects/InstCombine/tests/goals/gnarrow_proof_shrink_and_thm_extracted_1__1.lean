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

theorem shrink_and_thm.extracted_1._1 : ∀ (x : BitVec 64),
  True ∧ signExtend 64 (truncate 31 (x &&& 42#64)) ≠ x &&& 42#64 ∨
      True ∧ zeroExtend 64 (truncate 31 (x &&& 42#64)) ≠ x &&& 42#64 →
    HRefinement.IsRefinedBy (β := PoisonOr (BitVec 31)) (self :=
      @instHRefinementOfRefinement _
        (@PoisonOr.instRefinement _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec)))
      (PoisonOr.value (truncate 31 (x &&& 42#64))) PoisonOr.poison :=
sorry