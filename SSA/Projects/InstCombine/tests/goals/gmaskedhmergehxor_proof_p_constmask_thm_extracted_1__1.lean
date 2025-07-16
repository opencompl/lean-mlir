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

theorem p_constmask_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  True ∧ (x_1 &&& 65280#32 &&& (x &&& BitVec.ofInt 32 (-65281)) != 0) = true →
    HRefinement.IsRefinedBy (β := PoisonOr (BitVec 32)) (self :=
      @instHRefinementOfRefinement _
        (@PoisonOr.instRefinement _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec)))
      (PoisonOr.value (x_1 &&& 65280#32 ^^^ x &&& BitVec.ofInt 32 (-65281))) PoisonOr.poison :=
sorry